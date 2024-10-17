//
//  Link.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 17/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public enum Link: Equatable {
    public static func == (lhs: Link, rhs: Link) -> Bool {
        return lhs.urlValue == rhs.urlValue
    }

    case plainLink(URL)
    case Deeplink(DeeplinkContent)
}

public extension Link {

     var urlValue: URL {
        var result: URL

        switch self {
        case .plainLink(let url):
            result = url

        case .Deeplink(let content):
            result = content.url
        }

        return result
    }

    var DeeplinkContent: DeeplinkContent? {
        var result: DeeplinkContent?

        if case .Deeplink(let content) = self {
            result = content
        }

        return result
    }
}

extension Link: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(urlValue)
    }
}
