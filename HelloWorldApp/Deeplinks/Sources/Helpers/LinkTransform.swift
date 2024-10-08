//
//  LinkTransform.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 27/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Foundation
import Common
import CommonNet

public protocol TransformType {
    associatedtype Object
    associatedtype JSON

    func transformFromJSON(_ value: Any?) -> Object?
    func transformToJSON(_ value: Object?) -> JSON?
}

public class LinkTransform: TransformType {

    public init() {
        // ...
    }

    public func transformFromJSON(_ value: Any?) -> Link? {
        var result: Link?

        if let urlString = value as? String,
           let cleanString = urlString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: cleanString) {

            if let type = parseDeeplinkType(url: url) {
                let parameters = parseQueryParameters(url: url, as: DeeplinkContentParameters.self)
                result = .Deeplink(DeeplinkContent(url: url, type: type, parameters: parameters, option: nil))
            } else {
                result = .plainLink(url)
            }
        }

        return result
    }

    public func transformToJSON(_ value: Link?) -> String? {
        var result: URL?

        switch value {
        case .plainLink(let url):
            result = url

        case .Deeplink(let content):
            result = content.url

        default:
            break
        }

        return result?.absoluteString
    }

    private func parseQueryParameters<T: BaseResponse>(url: URL, as type: T.Type) -> T? {
        let fixedUrlStr = url.absoluteString.replacingOccurrences(of: Constants.httpSpaceShortcutSymbol, with: Constants.httpSpacePercentCode)
        var json = [String: Any]()

        guard let fixedURL = URL(string: fixedUrlStr),
              let queryItems = URLComponents(url: fixedURL, resolvingAgainstBaseURL: false)?.queryItems else {
            return nil
        }

        for item in queryItems {
            json[item.name] = item.value
        }

        return try? T(JSON: json)
    }

    private func parseDeeplinkType(url: URL) -> DeeplinkType? {
        var result: DeeplinkType?

        let stringType = url.lastPathComponent

        if let linkType = DeeplinkType(rawValue: stringType) {
            result = linkType
        } else {
            result = nil
        }

        return result
    }
}

// MARK: - Constants

fileprivate extension LinkTransform {

    enum Constants {
        static let httpSpaceShortcutSymbol = "+"
        static let httpSpacePercentCode = "%20"
        static let domainsSeparator = "."
    }
}
