//
//  GetMoreInfoResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class GetMoreInfoResponseMo: BaseResponse {

    /// Info titile
    public private(set) var title: String?

    /// Url of static img
    public private(set) var imageUrl: String?

    /// Text for user
    public private(set) var text: String?

    /// Title of button
    public private(set) var buttonTitle: String?

    /// Deeplink to magic screen
    public private(set) var deeplink: URL?

    required public init(map: Map) throws {
        title = try? map.value(Constants.title)
        imageUrl = try? map.value(Constants.imageUrl)
        text = try? map.value(Constants.text)
        buttonTitle = try? map.value(Constants.buttonTitle)
        deeplink = try? map.value(Constants.deeplink)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        title >>> map[Constants.title]
        imageUrl >>> map[Constants.imageUrl]
        text >>> map[Constants.text]
        buttonTitle >>> map[Constants.buttonTitle]
        deeplink >>> map[Constants.deeplink]
    }
}

// MARK: - Constants

fileprivate extension GetMoreInfoResponseMo {
    enum Constants {
        static let title = "title"
        static let imageUrl = "imageUrl"
        static let text = "text"
        static let buttonTitle = "buttonTitle"
        static let deeplink = "deeplink"
    }
}
