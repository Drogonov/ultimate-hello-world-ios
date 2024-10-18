//
//  NetLogger.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol NetLoggerProtocol: AnyObject {
    func log(request: URLRequest, loadedData: Data, response: URLResponse)

    func willSendRequest(request: URLRequest)
    func didReceiveResponse(response: URLResponse?, data: Data?, error: Error?, request: URLRequest)
}
