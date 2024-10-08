//
//  MoreInfoViewController.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
import DI
import Common
import Services
import CommonUI

// MARK: - MoreInfoViewController

final class MoreInfoViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: MoreInfoPresenterInput

    // MARK: UI Properties

    lazy var moreInfo: MoreInfoView = {
        MoreInfoView(
            model: self.presenter.getEmptyModel(),
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

// MARK: - MoreInfoViewInput

extension MoreInfoViewController: MoreInfoViewInput {

    func setView(with viewModel: MoreInfoViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension MoreInfoViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .backgroundColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(moreInfo)
    }
}

// MARK: - Private Methods

fileprivate extension MoreInfoViewController {
    private func configureView(with viewModel: MoreInfoViewModel) {
        self.moreInfo.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension MoreInfoViewController {

    // delete if not needed
    // enum Constants {}
}
