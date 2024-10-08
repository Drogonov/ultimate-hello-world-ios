//
//  ___VARIABLE_dataStorageName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - ___VARIABLE_productName___DataStorage

public struct ___VARIABLE_productName___DataStorage {

    // MARK: Public Properties

    public let response: String

    // MARK: Init
    // Move to CommonApplication if you want to use it with deeplinks 

    public init(
        response: String = "Hello World!"
    ) {
        self.response = response
    }
}
