//
//  AppConfiguration.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import CryptoKit
import Foundation

// sourcery: AutoMockable
public protocol AppConfigurationProtocol {
    var clientVersion: String { get }

    func getDateString(from date: Date) -> String
}

@objcMembers
public class AppConfiguration: NSObject, AppConfigurationProtocol {

    // MARK: Construction

    public static let sharedInstance = AppConfiguration()

    public override init() {
        self.clientVersion = "666"

        super.init()
    }

    // MARK: Properties

    public let clientVersion: String
    
    // MARK: Methods

    public func getDateString(from date: Date) -> String {
        return "getDateString"
    }
}
