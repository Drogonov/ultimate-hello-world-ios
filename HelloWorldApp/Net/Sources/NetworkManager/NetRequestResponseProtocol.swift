//
//  NTRequestResponseProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol NetRequestResponseProtocol: NetRequestProtocol {

    associatedtype Serializer: NetSerializerProtocol
    typealias ParsedModel = Serializer.ParsedModel

    var serializer: Serializer { get }
}
