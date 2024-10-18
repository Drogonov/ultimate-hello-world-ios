//
//  DispatchQueue+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public extension DispatchQueue {

    static func performOnMainThread(_ action: VoidBlock) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.sync {
                action()
            }
        }
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()

    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
