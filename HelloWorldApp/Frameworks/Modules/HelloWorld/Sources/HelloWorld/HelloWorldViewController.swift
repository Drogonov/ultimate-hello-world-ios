//
//  HelloWorldViewController.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
import SwiftUI
import DI
import Common
import Services
import Resources
import MasterComponents

// MARK: - HelloWorldViewController

final class HelloWorldViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: HelloWorldPresenterInput
    @ObservedObject var viewStore = HelloWorldViewStore()


    // MARK: UI Properties

    lazy var helloWorldView: HelloWorldView = {
        HelloWorldView(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - HelloWorldViewInput

extension HelloWorldViewController: HelloWorldViewInput {

    func setView(with viewModel: HelloWorldViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureNavigationBarButtons(with: viewModel.buttonTitle)
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension HelloWorldViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(helloWorldView)
    }
}

// MARK: - HelloWorldViewActionProtocol

extension HelloWorldViewController: HelloWorldViewActionProtocol {
    func viewMoreInfoTapped() {
        presenter.viewMoreInfoTapped()
    }
}

// MARK: - Private Methods

fileprivate extension HelloWorldViewController {
    private func configureNavigationBarButtons(with title: String) {
        let rightButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: #selector(didTapMoreInfoButton)
        )
        rightButton.tintColor = .red

        navigationItem.rightBarButtonItem = rightButton
    }

    @objc
    func didTapMoreInfoButton() {
        presenter.viewMoreInfoTapped()
    }
}
