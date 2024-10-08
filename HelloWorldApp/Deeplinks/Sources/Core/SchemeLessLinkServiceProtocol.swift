//
//  SchemeLessLinkServiceProtocol.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 27/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import CommonNet
import Persistence
import DI
import Foundation

// MARK: - GetPushRootServiceProtocol

// sourcery: AutoMockable
public protocol SchemeLessLinkServiceProtocol {
    func isSchemeLesslink(link: String) -> Bool
    func isSchemeLesslink(userInfo: [AnyHashable: Any]) -> Bool
    func convertSchemeLessLinkToHttps(urlString: String) -> URL?
}

// MARK: - GetPushRootService

public class SchemeLessLinkService: SchemeLessLinkServiceProtocol {

    private var cacher: CacheProtocol?

    public init(cacher: CacheProtocol?) {
        self.cacher = cacher
    }

    public func isSchemeLesslink(link: String) -> Bool {
        isSchemeLesslink(textForCheck: link)
    }

    public func isSchemeLesslink(userInfo: [AnyHashable: Any]) -> Bool {
        guard let links = userInfo[Constants.links] as? String else {
            return false
        }

        return isSchemeLesslink(textForCheck: links)
    }

    public func convertSchemeLessLinkToHttps(urlString: String) -> URL? {
        urlString.contains(URLScheme.http.rawValue)
            ? URL(string: "\(URLScheme.https.rawValue)\(urlString.dropFirst(URLScheme.http.lenght()))")
            : URL(string: "\(URLScheme.https.rawValue)\(urlString)")
    }
}

// MARK: - Private methods

fileprivate extension SchemeLessLinkService {

    func isSchemeLesslink(textForCheck: String) -> Bool {
        let domains: String? = cacher?.read(key: InfoURLsKey.pushLinkRoot)

        guard let domains = domains else {
            return false
        }

        var result = false
        let domainsSplitted = domains.components(separatedBy: Constants.separator)

        result = domainsSplitted.reduce(result) { partialResult, domain in
            partialResult || checkPushMessageForShortLink(text: textForCheck, domain: domain)
        }

        return result
    }

    func checkPushMessageForShortLink(text: String, domain: String) -> Bool {
        var result = false

        let urlPattern = "\(Constants.schemeLessLinkPatternFixedPart)\(domain)"
        let regex = try? NSRegularExpression(pattern: urlPattern, options: .caseInsensitive)
        let matches = regex?.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))

        if let matches = matches {
            result = matches.compactMap {
                if let range = Range($0.range, in: text) {
                    return URL(string: String(text[range]))
                }
                return nil
            }
            .isNotEmpty
        }

        return result
    }
}

// MARK: - Constants

fileprivate extension SchemeLessLinkService {
    enum  Constants {
        static let separator = ","
        static let links = "links"
        static let schemeLessLinkPatternFixedPart = "^(?!.*(http|https)).*"
    }
}
