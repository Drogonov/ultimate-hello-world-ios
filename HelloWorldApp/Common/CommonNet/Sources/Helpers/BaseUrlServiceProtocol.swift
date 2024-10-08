//
//  BaseUrlServiceProtocol.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol BaseURLServiceProtocol {
    var baseURL: String? { get }
    
    func setBaseURLValue(_ value: String)
    func resetDefaultBaseURL()
}
