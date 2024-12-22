//
//  ChangeLanguageViewController.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SnapKit
import SwiftUI
import DI
import Common
import Services
import MasterComponents

// MARK: - ChangeLanguageViewController

final class ChangeLanguageViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: ChangeLanguagePresenterInput
    @ObservedObject var viewStore = ChangeLanguageViewStore()

    // MARK: UI Properties

    lazy var languageView: ChangeLanguageView = {
        ChangeLanguageView(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - ChangeLanguageViewInput

extension ChangeLanguageViewController: ChangeLanguageViewInput {

    func setView(with viewModel: ChangeLanguageViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension ChangeLanguageViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(languageView)
    }
}

// MARK: - ChangeLanguageViewActionProtocol

extension ChangeLanguageViewController: ChangeLanguageViewActionProtocol {
    func switchToggled(on index: Int) {
        presenter.switchToggled(on: index)
    }
    
    func viewButtonTapped() {
        presenter.viewButtonTapped()
    }
}
