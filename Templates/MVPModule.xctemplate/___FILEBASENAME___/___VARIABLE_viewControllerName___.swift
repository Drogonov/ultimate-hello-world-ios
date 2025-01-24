//
//  ___VARIABLE_viewControllerName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import DI
import UIKit
import SnapKit
import SwiftUI
import Common
import MasterComponents

// MARK: - ___VARIABLE_productName___ViewController

final class ___VARIABLE_productName___ViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: ___VARIABLE_productName___PresenterInput
    @ObservedObject var viewStore = ___VARIABLE_productName___ViewStore()

    // MARK: UI Properties

    lazy var swiftUIView: ___VARIABLE_productName___View = {
        ___VARIABLE_productName___View(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - ___VARIABLE_productName___ViewInput

extension ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewInput {

    func setView(with viewModel: ___VARIABLE_productName___ViewModel) {
        viewStore.update(with: viewModel)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension ___VARIABLE_productName___ViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(swiftUIView)
    }
}

// MARK: - ___VARIABLE_productName___ViewActionProtocol

extension ___VARIABLE_productName___ViewController:  ___VARIABLE_productName___ViewActionProtocol {
    func viewButtonTapped() {
        presenter.viewButtonTapped()
    }
}

// MARK: - Private Methods

fileprivate extension ___VARIABLE_productName___ViewController {
    // delete if not needed
}

// MARK: - Constants

fileprivate extension ___VARIABLE_productName___ViewController {
    // delete if not needed
    // enum Constants {}
}
