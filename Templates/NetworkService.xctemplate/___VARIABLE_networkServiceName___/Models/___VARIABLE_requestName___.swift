//
//  ___VARIABLE_requestName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import ObjectMapper
import Net

open class ___VARIABLE_productName___RequestMo: BaseRequest {

    /// Some Text
    public private(set) var code: String?

    public init(
        code: String?
    ) {
        self.code = code

        super.init()
    }

    public required init?(map: Map) {
        fatalError("Not implemented. Use init(...) instead")
    }

    open override func mapping(map: Map) {
        code <- map[Constants.code]
    }
}

// MARK: - Constants

fileprivate extension ___VARIABLE_productName___RequestMo {
    enum Constants {
        static let code = "code"
    }
}
