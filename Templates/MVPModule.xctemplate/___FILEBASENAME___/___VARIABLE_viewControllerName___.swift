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
import Common
import CommonUI

// MARK: - ___VARIABLE_productName___ViewController

final class ___VARIABLE_productName___ViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: ___VARIABLE_productName___PresenterInput

    // MARK: UI Properties

    lazy var testView: ___VARIABLE_productName___View = {
        ___VARIABLE_productName___View(
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

// MARK: - ___VARIABLE_productName___ViewInput

extension ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewInput {

    func setView(with viewModel: ___VARIABLE_productName___ViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension ___VARIABLE_productName___ViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .backgroundColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(testView)
    }
}

// MARK: - Private Methods

fileprivate extension ___VARIABLE_productName___ViewController {
    private func configureView(with viewModel: ___VARIABLE_productName___ViewModel) {
        self.testView.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension ___VARIABLE_productName___ViewController {

    // delete if not needed
    // enum Constants {}
}
