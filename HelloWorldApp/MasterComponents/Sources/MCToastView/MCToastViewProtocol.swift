//
//  MCToastViewProtocol.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

// sourcery: AutoMockable, isOpen
public protocol MCToastViewProtocol {
    func showToast(viewModel: MCInfoToastViewModel)
    func showToast(viewModel: MCInfoToastViewModel, completion: (() -> Void)?)
}

// MARK: - Public Methods

extension MCToastViewProtocol {

    public func showToast(viewModel: MCInfoToastViewModel) {
        showToast(viewModel: viewModel, completion: nil)
    }

    public func showToast(viewModel: MCInfoToastViewModel, completion: (() -> Void)?) {
        guard let window = UIApplication.shared.currentKeyWindow,
              !window.subviews.contains(where: { $0 is MCInfoToastView }) else {
            return
        }

        let toastView = MCInfoToastView()
        window.addSubview(toastView)
        toastView.updateViewConstraints()
        toastView.showInfo(viewModel: viewModel) {
            toastView.removeFromSuperview()
            completion?()
        }
    }
}
