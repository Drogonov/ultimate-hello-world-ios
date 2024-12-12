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

    @DelayedImmutable var authNetworkService: AuthNetworkServiceProtocol?

    @ObservedObject var viewModel = OTPViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: OTPRouterInput
    ) {
        self.router = router
        self.viewModel.delegate = self
    }
}

// MARK: - OTPPresenterInput

extension OTPPresenter: OTPPresenterInput {
    func viewIsReady() {
        let model = OTPModel(title: dataStorage?.email)

        viewModel.navigationTitle = model.title ?? .empty
        updateViewModel()

        self.view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func verifyButtonTapped() {
        let otp = getOTP()
        if otp.count == 6 {
            handleVerifyOTP(otp: otp)
        }
    }

    func resendButtonTapped() {
        handleResendOTP()
    }

    func getEmptyModel() -> OTPViewModel {
        viewModel
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

// MARK: - OTPViewModelDelegate

extension OTPPresenter: OTPViewModelDelegate {
    func otpTextFieldsDidChange() {
        viewModel.isVerifyButtonEnabled = getOTP().count == 6
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
        viewModel.isVerifyButtonLoading = true

        Task {
            do {
                let response = try await authNetworkService?.verifyOTPData(request: request, forceRequest: false)
                viewModel.isVerifyButtonLoading = false
                handleVerifyOTPSuccess(response: response)
            } catch {
                viewModel.isVerifyButtonLoading = false
                handleFailure(error: error.getTopLayerErrorResponse())
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
                handleResendOTPSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
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
        guard let response = response else {
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
    func updateViewModel() {
        viewModel.navigationTitle = "Enter OTP"
        viewModel.resendButtonText = "Resend OTP"
        viewModel.verifyButtonText = "Verify"

        clearOtpTextField()
    }

    func clearOtpTextField() {
        viewModel.otpTextFields = [
            0: .empty, 1: .empty, 2: .empty, 3: .empty, 4: .empty, 5: .empty
        ]
    }

    func getOTP() -> String {
        var otp: String = ""
        for index in 0...5 {
            otp += viewModel.otpTextFields[index] ?? .empty
        }

        return otp.trim()
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

    // delete if not needed
    // enum Constants {}
}
