//
//  DefaultErrorHandler.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Resources
import MasterComponents
import Persistence
import CommonNet
import CommonApplication

public enum ErrorReportingType: String {
    case none = "none"
    case toast = "toast"
    case alert = "alert"
}

public enum ErrorHandlerType {
    public static let nonAuth = "nonAuth"
    public static let common = "common"
}

public protocol DefaultErrorHandlerProtocol: NetErrorHandler, MCToastViewProtocol, NativeAlertProtocol {
    var errorReportingType: ErrorReportingType { get }
    var sessionCache: CacheProtocol? { get }
}

extension DefaultErrorHandlerProtocol {

    public func defaultLogoutAction() {}

    public func handle(error: Error?) throws {
        try defaultHandle(error: error)
    }

    public func defaultHandle(error: Error?) throws {
        guard let error = error as? ApiError else {
            if let error = error {
                throw error
            }
            return
        }

        switch error {
        case .topLayerError(let reason):
            try handleTop(error: error, reason: reason)

        case let .applicationLayerError(reason, responseInfo):
            try handleApplication(error: error, reason: reason, responseInfo: responseInfo)

        case .transportLayerError(let reason):
            try handleTransport(error: error, reason: reason)

        case .prepareLayerError(_):
            throw error
        }
    }

    public func appOutdate() {}

    public func handleTransport(error: Error, reason: TransportErrorReason) throws {

        switch reason {
        case .connection:

            show(
                dialog: .init(
                    title: ResourcesStrings.internetNotAvailableTitle(),
                    description: ResourcesStrings.internetNotAvailableMessage(),
                    defaultTitle: ResourcesStrings.ok()
                )
            )

            if errorReportingType == .alert {
                DispatchQueue.performOnMainThread {
                    showToast(viewModel: .init(text: ResourcesStrings.internetNotAvailable()))
                }
            }

        case .notAvailableServer(_, _):
            show(
                criticalMessage: ResourcesStrings.serverInaccessibleMessage(),
                title: ResourcesStrings.serverInaccessibleTitle()
            )
        }
        throw error
    }

    public func show(criticalMessage text: String, title: String? = nil) {
        let storage = DialogDataStorage(
            title: title ?? String.empty,
            description: text,
            defaultTitle: ResourcesStrings.ok(),
            defaultAction: {
                self.defaultLogoutAction()
            }
        )

        show(dialog: storage)
    }

    public func show(message text: String? = nil, dialog: DialogDataStorage? = nil) {
        DispatchQueue.performOnMainThread {
            let isShownAlert = sessionCache?.read(Bool.self, withKey: CommonCacheKey.isShownAlert) ?? false
            guard !isShownAlert else {
                return
            }

            switch errorReportingType {
            case .none:
                break

            case .toast:
                sessionCache?.write(true, withKey: CommonCacheKey.isShownAlert)
                let message = text ?? dialog?.description ?? String.empty
                showToast(viewModel: .init(text: message)) {
                    dialog?.defaultAction?()
                    self.sessionCache?.write(false, withKey: CommonCacheKey.isShownAlert)
                }

            case .alert:
                sessionCache?.write(true, withKey: CommonCacheKey.isShownAlert)
                let alert = NativeAlertViewModel.firstButtonOptionalAlert(
                    title: dialog?.title ?? text,
                    message: dialog?.description,
                    firstTitle: dialog?.cancelTitle,
                    firstAction: {
                        dialog?.cancelAction?()
                        self.sessionCache?.write(false, withKey: CommonCacheKey.isShownAlert)
                    },
                    secondTitle: dialog?.defaultTitle ?? ResourcesStrings.ok(),
                    secondAction: {
                        dialog?.defaultAction?()
                        self.sessionCache?.write(false, withKey: CommonCacheKey.isShownAlert)
                    }
                )
                show(alert: alert)
            }
        }
    }

    public func messageWithTraceId(_ message: String, responseInfo: ResponseInfo?) -> String {
        guard let traceId = responseInfo?.traceID() else {
            return message
        }
        return ResourcesStrings.errorWithTraceId(message, traceId)
    }
}

// MARK: - Private Methods

fileprivate extension DefaultErrorHandlerProtocol {
    func handleApplication(error: Error, reason: ApplicationErrorReason, responseInfo: ResponseInfo?) throws {
        if case let .response(statusCode, errorReason) = reason {

            switch statusCode {
            case .movedTemporary:
                return

            case .unauthorized:
                defaultLogoutAction()

            case .forbidden:

                let message = messageWithTraceId(
                    ResourcesStrings.forbiddenErrorDefaultMessage(),
                    responseInfo: responseInfo
                )
                show(
                    criticalMessage: message,
                    title: ResourcesStrings.attention()
                )

            case .notFound, .precondition, .internalServerError, .badGateway:

                let message = messageWithTraceId(
                    ResourcesStrings.serverInaccessibleMessage(),
                    responseInfo: responseInfo
                )
                show(
                    criticalMessage: message,
                    title: ResourcesStrings.serverInaccessibleTitle()
                )

            case .notImplemented:
                if let errorResponse = errorReason as? ErrorResponseMo,
                    errorResponse.errorCode == .unsupported {
                    let storage = DialogDataStorage(
                        title: ResourcesStrings.attention(),
                        description: ResourcesStrings.appOutdated(),
                        defaultTitle: ResourcesStrings.refresh(),
                        defaultAction: {
                            self.appOutdate()
                        }
                    )
                    show(dialog: storage)
                }

            default:
                break
            }
        } else if case let .conversion(reason, _, _) = reason {
            #if DEBUG
            show(message: reason)
            #endif
        }
        throw error
    }

    func handleTop(error: Error, reason: TopErrorReason) throws {
        /// use self custom ErrorHandler
        throw error
    }

    func show(alert: NativeAlertViewModel) {
        DispatchQueue.main.async {
            self.showNativeAlert(viewModel: alert)
        }
    }
}

fileprivate enum Constants {
    static let constantUrlPart: String = "http://itunes.apple.com/lookup?bundleId="
    static let resultsKey: String = "results"
    static let trackIdKey: String = "trackId"
    static let constantAppStoreUrlPart: String = "itms-apps://itunes.apple.com/app/id"
}
