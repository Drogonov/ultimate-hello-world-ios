//
//  DeviceConfiguration.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

@objcMembers
public class DeviceConfiguration: NSObject, DeviceConfigurationProtocol {

    // MARK: Construction

    public static let sharedInstance = DeviceConfiguration()

    public var deviceModelName: String {
        return "Model Name"
    }

    public var deviceOsName: String {
        return "IPHONE"
    }

    private override init() {
        // Parent processing
        super.init()
    }

    public func getDeviceId() -> String? {
        return "666"
    }

    public func getUUID() -> String {
        return "666"
    }
}
