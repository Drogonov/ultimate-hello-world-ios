//
//  ___VARIABLE_responseName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import ObjectMapper

public class ___VARIABLE_productName___ResponseMo: BaseResponse {

    /// Some Text
    public private(set) var text: String?

    required public init(map: Map) throws {
        text = try? map.value(Constants.text)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        text >>> map[Constants.text]
    }
}

// MARK: - Constants

fileprivate extension ___VARIABLE_productName___ResponseMo {
    enum Constants {
        static let text = "text"
    }
}
