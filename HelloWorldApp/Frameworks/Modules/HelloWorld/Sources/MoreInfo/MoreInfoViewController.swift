//
//  MoreInfoViewController.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
import SwiftUI
import DI
import Common
import Services
import MasterComponents

// MARK: - MoreInfoViewController

final class MoreInfoViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: MoreInfoPresenterInput
    @ObservedObject var viewStore = MoreInfoViewStore()

    // MARK: UI Properties

    lazy var moreInfo: MoreInfoView = {
        MoreInfoView(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - MoreInfoViewInput

extension MoreInfoViewController: MoreInfoViewInput {

    func setView(with viewModel: MoreInfoViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension MoreInfoViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(moreInfo)
    }
}

// MARK: - MoreInfoViewActionProtocol

extension MoreInfoViewController: MoreInfoViewActionProtocol {
    func viewButtonTapped() {
        presenter.viewButtonTapped()
    }
}
