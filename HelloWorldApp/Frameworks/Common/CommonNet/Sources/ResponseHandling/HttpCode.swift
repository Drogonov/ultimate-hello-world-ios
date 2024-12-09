//
//  HttpCode.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum HttpCode: Hashable {
    case none
    case ok
    case movedTemporary
    case badRequest
    case unauthorized
    case forbidden
    case unprocessableEntity
    case notFound
    case precondition
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case unknownError
    case undefined(Int)

    // MARK: Methods

    static public func make(rawValue: Int?) -> HttpCode {
        let statusCode = rawValue ?? 0
        return HttpCode(rawValue: statusCode) ?? HttpCode.none
    }
}

extension HttpCode: RawRepresentable {

    // MARK: Properties

    public var rawValue: Int {
        switch self {
        case .none:
            return 0

        case .ok:
            return 200

        case .movedTemporary:
            return 302

        case .badRequest:
            return 400

        case .unauthorized:
            return 401

        case .forbidden:
            return 403

        case .notFound:
            return 404

        case .precondition:
            return 412

        case .unprocessableEntity:
            return 422

        case .internalServerError:
            return 500

        case .notImplemented:
            return 501

        case .badGateway:
            return 502

        case .serviceUnavailable:
            return 503

        case .unknownError:
            return 520

        case .undefined(let code):
            return code
        }
    }

    // MARK: Init

    public init?(rawValue: Int) {

        switch rawValue {
        case 0:
            self = .none

        case 200:
            self = .ok

        case 302:
            self = .movedTemporary

        case 400:
            self = .badRequest

        case 401:
            self = .unauthorized

        case 403:
            self = .forbidden

        case 404:
            self = .notFound

        case 412:
            self = .precondition

        case 422:
            self = .unprocessableEntity

        case 500:
            self = .internalServerError

        case 501:
            self = .notImplemented

        case 502:
            self = .badGateway

        case 503:
            self = .serviceUnavailable

        case 520:
            self = .unknownError

        default:
            self = .undefined(rawValue)
        }
    }

    // MARK: Methods

    public func isUndefined() -> Bool {
        switch self {
        case .undefined:
            return true

        default:
            return false
        }
    }

    public func isAcceptable() -> Bool {
        var acceptableStatusCodes: Set<Int> = Set(200..<300)
        return acceptableStatusCodes.contains(self.rawValue)
    }

    public func isTopLevel() -> Bool {
        var acceptableStatusCodes = Set<Int>()
        acceptableStatusCodes.insert(400)
        acceptableStatusCodes.insert(422)
        return acceptableStatusCodes.contains(self.rawValue)
    }
}
