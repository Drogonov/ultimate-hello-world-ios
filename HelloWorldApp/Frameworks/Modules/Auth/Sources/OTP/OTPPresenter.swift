//
//  OTPPresenter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI
import DI
import CommonApplication
import Services
import CommonNet
import Net
import Common
import MasterComponents
import Resources

// MARK: - OTPPresenter

class OTPPresenter {

    // MARK: Public Properties

    weak var view: OTPViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: OTPModuleOutput?

    private var router: OTPRouterInput
    private var dataStorage: OTPDataStorage?
    private var viewModel: OTPViewModel?

    // MARK: Services

    @DelayedImmutable var authNetworkService: AuthNetworkServiceProtocol?

    // MARK: Init

    init(
        router: OTPRouterInput
    ) {
        self.router = router
    }
}

// MARK: - OTPPresenterInput

extension OTPPresenter: OTPPresenterInput {

    func viewIsReady() {
        viewModel = getDefaultViewModel()

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewDidChangeOTPTextField(with index: Int, text: String) {
        var value: String = .empty
        var indexToFocus: Int?

        switch (
            text.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil,
            text.count <= 1
        ) {
        case (true, true):
            value = text
            indexToFocus = getIndexToFocus(index)

        case (true, false):
            value = String(text.last ?? Character(""))
            indexToFocus = getIndexToFocus(index)

        case (false, _):
            value = .empty
            indexToFocus = index
        }

        viewModel?.otpTextFieldData[index] = value
        viewModel?.otpFocusedTextFieldIndex = indexToFocus
        viewModel?.isVerifyButtonEnabled = ifAllSymbolsAdded()

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewDidTapOTPTextField(with index: Int) {
        viewModel?.otpFocusedTextFieldIndex = index

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewDidTapVerifyButton() {
        handleVerifyOTP(otp: getOTP())
    }

    func viewDidTapResendButton() {
        handleResendOTP()
    }
}

// MARK: - OTPModuleInput

extension OTPPresenter: OTPModuleInput {    
    func set(dataStorage: OTPDataStorage) {
        self.dataStorage = dataStorage
    }
    
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? OTPModuleOutput
    }
}

// MARK: - OTPModuleOutput

extension OTPPresenter: OTPModuleOutput {}

// MARK: - Task

fileprivate extension OTPPresenter {
    func handleVerifyOTP(otp: String) {
        guard let dataStorage else {
            return
        }

        let request = AuthRequestMo(email: dataStorage.email, password: otp)
        viewModel?.isVerifyButtonLoading = true

        Task {
            do {
                let response = try await authNetworkService?.verifyOTPData(request: request, forceRequest: false)
                viewModel?.isVerifyButtonLoading = false
                await handleVerifyOTPSuccess(response: response)
            } catch {
                viewModel?.isVerifyButtonLoading = false
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func handleResendOTP() {
        guard let dataStorage else {
            return
        }

        let request = AuthRequestMo(email: dataStorage.email, password: dataStorage.password)

        Task {
            do {
                let response = try await authNetworkService?.resendOTPData(request: request, forceRequest: false)
                await handleResendOTPSuccess(response: response)
            } catch {
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }
}

// MARK: - @MainActor Handle

fileprivate extension OTPPresenter {
    @MainActor
    func handleVerifyOTPSuccess(response: TokensResponseMo?) {
        guard let response = response else {
            return
        }

        if let token = response.accessToken {
            KeychainJWTProvider.shared.save(.accessToken, token)
        }

        if let token = response.refreshToken {
            KeychainJWTProvider.shared.save(.refreshToken, token)
        }

        router.goToMainTabBar()
    }

    @MainActor
    func handleResendOTPSuccess(response: TokensResponseMo?) {
        guard response != nil else {
            return
        }

        handleAlert(title: "OTP send", message: "Please check your email and come back to type your new otp")
    }

    @MainActor
    func handleFailure(error: ErrorResponseMo?) {
        guard let error = error else {
            return
        }

        handleAlert(title: "Error", message: error.errorMsg)
    }
}

// MARK: - Private Methods

fileprivate extension OTPPresenter {
    func getDefaultViewModel() -> OTPViewModel {
        OTPViewModel(
            navigationTitle: "Enter OTP",
            otpTextFieldData: [
                0: .empty, 1: .empty, 2: .empty, 3: .empty, 4: .empty, 5: .empty
            ],
            otpFocusedTextFieldIndex: 0,
            verifyButtonText: "Verify",
            isVerifyButtonLoading: false,
            isVerifyButtonEnabled: false,
            resendButtonText: "Resend OTP"
        )
    }

    func getOTP() -> String {
        var otp: String = ""
        for index in 0...5 {
            otp += viewModel?.otpTextFieldData[index] ?? .empty
        }

        return otp.trim()
    }

    func getIndexToFocus(_ currentIndex: Int) -> Int? {
        var indexToFocus: Int?

        if !ifAllSymbolsAdded(), currentIndex + 1 == Constants.maximumSymboldCount {
            indexToFocus = nil
        } else {
            indexToFocus = currentIndex + 1
        }

        return indexToFocus
    }

    func ifAllSymbolsAdded() -> Bool {
        getOTP().count == Constants.maximumSymboldCount
    }

    func handleAlert(
        title: String?,
        message: String?,
        firstAction: VoidBlock? = nil
    ) {
        let body = NativeAlertViewModel.Body(
            title: title,
            message: message
        )

        let buttons = NativeAlertViewModel.Buttons(
            firstTitle: ResourcesStrings.ok(),
            firstAction: firstAction
        )

        let viewModel = NativeAlertViewModel(
            body: body,
            buttons: buttons
        )

        showNativeAlert(viewModel: viewModel)
    }
}

// MARK: - Constants

fileprivate extension OTPPresenter {
     enum Constants {
         static let maximumSymboldCount: Int = 6
     }
}
