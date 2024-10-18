//
//  JsonLoader.swift
//  CommonTest
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import ObjectMapper
import CommonNet
import Common
import XCTest

public class JsonLoader {

    public static func loadObject<T: BaseResponse>(filename: String, bundle: Bundle?) throws -> T {
        let converter: AbstractCallResultConverter = AbstractValidatableModelConverter<T>()
        let json = try loadJson(filename: filename, bundle: bundle)
        do {
            return try converter.convert(object: json)
        } catch let error as ConversionError {
            throw JsonLoaderError.notParse(filename, error)
        } catch {
            throw JsonLoaderError.notParse(filename, nil)
        }
    }

    public static func loadObjects<T: BaseResponse>(filename: String, bundle: Bundle?) throws -> [T] {
        let converter: AbstractCallResultConverter = AbstractValidatableModelArrayConverter<T>()
        let json = try loadJson(filename: filename, bundle: bundle)
        do {
            return try converter.convert(object: json)
        } catch let error as ConversionError {
            throw JsonLoaderError.notParse(filename, error)
        } catch {
            throw JsonLoaderError.notParse(filename, nil)
        }
    }

    public static func loadJson(filename: String, bundle: Bundle?) throws -> Any {
        let data = try loadData(filename: filename, bundle: bundle)
        if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
            return json
        } else {
            throw JsonLoaderError.notParse(filename, nil)
        }
    }

    public static func loadData(filename: String, bundle: Bundle?) throws -> Data {
        guard filename.isNotEmpty else {
            throw JsonLoaderError.emptyName
        }

        if let filepath = bundle?.path(forResource: filename, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: filepath), options: .alwaysMapped) {
            return data
        } else {
            throw JsonLoaderError.notLoad(filename)
        }
    }
}

extension JsonLoader {
    public static func loadData(filename: String) throws -> Data {
        let bundle = BundleProvider.shared.bundleForResourceName(filename)
        return try loadData(filename: filename, bundle: bundle)
    }
}
