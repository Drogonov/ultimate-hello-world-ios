//
//  MainTabBarProviderProtocol.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import UIKit

public protocol MainTabBarProviderProtocol: AnyObject {
    func provideMainTabBar() -> UITabBarController
}
