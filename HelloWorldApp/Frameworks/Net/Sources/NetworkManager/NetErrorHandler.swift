//
//  NetErrorHandler.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol NetErrorHandler {
    func handle(error: Error?) throws
}
