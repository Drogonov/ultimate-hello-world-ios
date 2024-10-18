//
//  DeviceConfigurationProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol DeviceConfigurationProtocol {
    var deviceModelName: String { get }
    var deviceOsName: String { get }

    func getDeviceId() -> String?
    func getUUID() -> String
}
