//
//  MagicViewController.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
import DI
import Common
import Services
import CommonUI
import CommonApplication

// MARK: - MagicViewController

final class MagicViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: MagicPresenterInput

    // MARK: UI Properties

    lazy var testView: MagicView = {
        MagicView(
            model: self.presenter.getEmptyModel()
        )
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backAction = UIAction { _ in
            NavigationStackProvider.shared.set(isNavigationBarHidden: true)
            self.navigationController?.popViewController(animated: true)
        }

        configure()
        presenter.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NavigationStackProvider.shared.set(isNavigationBarHidden: false)
        presenter.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter.viewWillAppear()
    }

    // MARK: Selectors
    // ...
}

// MARK: - MagicViewInput

extension MagicViewController: MagicViewInput {

    func setView(with viewModel: MagicViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension MagicViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(testView)
    }
}

// MARK: - Private Methods

fileprivate extension MagicViewController {
    private func configureView(with viewModel: MagicViewModel) {
        self.testView.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension MagicViewController {

    // delete if not needed
    // enum Constants {}
}
