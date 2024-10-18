//
//  DeeplinkContentParametersMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 17/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import ObjectMapper
import Foundation

public final class DeeplinkContentParametersMo: BaseResponse {

    public var languageCode: String?
    public var utmSource: String?
    public var utmMedium: String?
    public var utmCampaign: String?
    public var utmContent: String?

    required public init(map: Map) throws {
        languageCode = try? map.value(Constants.languageCode)

        utmSource = try? map.value(Constants.utmSource)
        utmMedium = try? map.value(Constants.utmMedium)
        utmCampaign = try? map.value(Constants.utmCampaign)
        utmContent = try? map.value(Constants.utmContent)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)

        languageCode >>> map[Constants.languageCode]
        utmSource >>> map[Constants.utmSource]
        utmMedium >>> map[Constants.utmMedium]
        utmCampaign >>> map[Constants.utmCampaign]
        utmContent >>> map[Constants.utmContent]
    }

    private enum Constants {
        static let languageCode = "languageCode"
        static let utmSource = "utm_source"
        static let utmMedium = "utm_medium"
        static let utmCampaign = "utm_campaign"
        static let utmContent = "utm_content"
    }
}
