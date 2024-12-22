//
//  OTPViewController.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import DI
import UIKit
import SwiftUI
import SnapKit
import Common
import MasterComponents

// MARK: - OTPViewController

final class OTPViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: OTPPresenterInput
    @ObservedObject var viewStore = OTPViewStore()

    // MARK: UI Properties

    lazy var otpView: OTPView = {
        OTPView(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - OTPViewInput

extension OTPViewController: OTPViewInput {
    func setView(with viewModel: OTPViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension OTPViewController: ViewConfigurable {
    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(otpView)
    }
}

// MARK: - OTPViewActionProtocol

extension OTPViewController: OTPViewActionProtocol {
    func viewDidChangeOTPTextField(with index: Int, text: String) {
        presenter.viewDidChangeOTPTextField(with: index, text: text)
    }
    
    func viewDidTapOTPTextField(with index: Int) {
        presenter.viewDidTapOTPTextField(with: index)
    }
    
    func viewDidTapVerifyButton() {
        presenter.viewDidTapVerifyButton()
    }
    
    func viewDidTapResendButton() {
        presenter.viewDidTapResendButton()
    }
}
