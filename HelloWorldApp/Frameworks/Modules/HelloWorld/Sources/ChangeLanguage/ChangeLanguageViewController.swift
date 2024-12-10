//
//  ChangeLanguageViewController.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
import DI
import Common
import Services
import MasterComponents

// MARK: - ChangeLanguageViewController

final class ChangeLanguageViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: ChangeLanguagePresenterInput

    // MARK: UI Properties

    lazy var testView: ChangeLanguageView = {
        ChangeLanguageView(
            model: self.presenter.getEmptyModel(),
            switchToggled: { index in 
                self.presenter.switchToggled(on: index)
            },
            buttonTapped: {
                self.presenter.viewButtonTapped()
            }
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

    // MARK: Selectors
    // ...
}

// MARK: - ChangeLanguageViewInput

extension ChangeLanguageViewController: ChangeLanguageViewInput {

    func setView(with viewModel: ChangeLanguageViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension ChangeLanguageViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(testView)
    }
}

// MARK: - Private Methods

fileprivate extension ChangeLanguageViewController {
    private func configureView(with viewModel: ChangeLanguageViewModel) {
        self.testView.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension ChangeLanguageViewController {

    // delete if not needed
    // enum Constants {}
}
