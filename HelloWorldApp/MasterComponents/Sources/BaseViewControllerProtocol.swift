//
//  BaseViewControllerProtocol.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit
import Common

public protocol BaseViewControllerProtocol where Self: UIViewController {
    func setNavigationBarTitle(with title: String)
    func configureNavigationBar()

    func addMainViewToViewController<T: View>(_ newView: T)
    func addUIViewToViewController(_ newView: UIView)
}

public extension BaseViewControllerProtocol where Self: UIViewController {
    func setNavigationBarTitle(with title: String) {
        self.navigationItem.title = title
    }

    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.textPrimaryColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
    }

    func addMainViewToViewController<T: View>(_ newView: T) {
        let viewCtrl = UIHostingController(rootView: newView)
        addChild(viewCtrl)
        view.addSubview(viewCtrl.view)

        viewCtrl.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        viewCtrl.didMove(toParent: self)
    }

    func addUIViewToViewController(_ newView: UIView) {
        view.addSubview(newView)

        newView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

