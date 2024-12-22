//
//  MagicViewController.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SwiftUI
import SnapKit
import DI
import Common
import Services
import CommonApplication
import MasterComponents

// MARK: - MagicViewController

final class MagicViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: MagicPresenterInput
    @ObservedObject var viewStore = MagicViewStore()

    // MARK: UI Properties

    lazy var magicView: MagicView = {
        MagicView(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backAction = UIAction { [weak self] _ in
            self?.presenter.viewNavigationItemBackAction {
                self?.navigationController?.popViewController(animated: true)
            }
        }

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - MagicViewInput

extension MagicViewController: MagicViewInput {

    func setView(with viewModel: MagicViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension MagicViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(magicView)
    }
}

// MARK: - MagicViewActionProtocol

extension MagicViewController: MagicViewActionProtocol {
    func viewNavigationItemBackAction(_ completion: Common.VoidBlock?) {
        presenter.viewNavigationItemBackAction(completion)
    }

    func viewButtonTapped() {
        presenter.viewButtonTapped()
    }
}
