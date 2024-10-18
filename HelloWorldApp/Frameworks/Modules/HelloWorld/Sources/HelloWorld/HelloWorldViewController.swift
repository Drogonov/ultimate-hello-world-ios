//
//  HelloWorldViewController.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
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

    // MARK: UI Properties

    lazy var helloWorldView: HelloWorldView = {
        HelloWorldView(
            model: self.presenter.getEmptyModel()
        )
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter.viewWillAppear()
    }
}

// MARK: - HelloWorldViewInput

extension HelloWorldViewController: HelloWorldViewInput {

    func setView(with viewModel: HelloWorldViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
        configureNavigationBarButtons(with: viewModel.buttonTitle)
    }
}

// MARK: - ViewConfigurable

extension HelloWorldViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(helloWorldView)
    }
}

// MARK: - Private Methods

fileprivate extension HelloWorldViewController {
    private func configureView(with viewModel: HelloWorldViewModel) {
        self.helloWorldView.model = viewModel
    }

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

// MARK: - Constants

fileprivate extension HelloWorldViewController {

    // delete if not needed
    // enum Constants {}
}
