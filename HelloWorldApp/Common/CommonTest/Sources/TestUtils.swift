//
//  TestUtils.swift
//  CommonNet
//
//  Created by Anton Vlezko on 15/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import ObjectMapper
import CommonNet
import XCTest

public class TestUtils {

    // MARK: - Construction

    public static let shared = TestUtils()

    private init() {}

    // MARK: - Methods

    public func loadObjectFromJson<T: BaseResponse>(filename: String, bundle: Bundle?) -> T {
        var item: T?
        do {
            item = try JsonLoader.loadObject(filename: filename, bundle: bundle)
        } catch {
            errorHandler(error, filename: filename)
        }

        return item!
    }

    public func loadObjectsFromJson<T: BaseResponse>(filename: String, bundle: Bundle?) -> [T] {
        var items: [T]?
        do {
            items = try JsonLoader.loadObjects(filename: filename, bundle: bundle)
        } catch {
            errorHandler(error, filename: filename)
        }
        return items!
    }

    public func loadJson(_ filename: String, bundle: Bundle?) -> [String: Any] {
        var json: [String: Any]?
        do {
            json = try JsonLoader.loadJson(filename: filename, bundle: bundle) as? [String: Any]
        } catch {
            errorHandler(error, filename: filename)
        }
        return json!
    }

    public func loadData(_ filename: String, bundle: Bundle?) -> Data {
        var data: Data?
        do {
            data = try JsonLoader.loadData(filename: filename, bundle: bundle)
        } catch {
            errorHandler(error, filename: filename)
        }
        return data!
    }
}

// MARK: - Private Methods

fileprivate extension TestUtils {
    func errorHandler(_ error: Error, filename: String) {
        guard let error = error as? JsonLoaderError else {
            XCTFail(error.localizedDescription)
            return
        }

        switch error {
        case .emptyName:
            XCTAssert(!filename.isEmpty, error.description)

        default:
            XCTFail(error.description)
        }
    }

    func prefix(_ file: StaticString, _ line: UInt) -> String {
        let fileURL = URL(fileURLWithPath: String(describing: file))
        return "\(fileURL.lastPathComponent):\(line)"
    }
}

// MARK: - extension - TestUtils

extension TestUtils {

    public func loadObjectFromJson<T: BaseResponse>(filename: String) -> T {
        let bundle = Bundle(for: type(of: self))
        return loadObjectFromJson(filename: filename, bundle: bundle)
    }

    public func loadObjectsFromJson<T: BaseResponse>(filename: String) -> [T] {
        let bundle = Bundle(for: type(of: self))
        return loadObjectsFromJson(filename: filename, bundle: bundle)
    }

    public func loadJson(_ filename: String) -> [String: Any] {
        let bundle = Bundle(for: type(of: self))
        return loadJson(filename, bundle: bundle)
    }

    public func loadData(from filename: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        return loadData(filename, bundle: bundle)
    }
}

// MARK: - extension - XCTestCase

extension XCTestCase {

    fileprivate var bundle: Bundle { Bundle(for: type(of: self)) }

    public func loadObjectFromJson<T: BaseResponse>(_ objectType: T.Type = T.self, filename: String) -> T {
        TestUtils.shared.loadObjectFromJson(filename: filename, bundle: bundle)
    }

    public func loadObjectsFromJson<T: BaseResponse>(_ objectType: T.Type = T.self, filename: String) -> [T] {
        TestUtils.shared.loadObjectsFromJson(filename: filename, bundle: bundle)
    }

    public func loadJson(_ filename: String) -> [String: Any] {
        TestUtils.shared.loadJson(filename, bundle: bundle)
    }

    public func loadData(from filename: String) -> Data {
        TestUtils.shared.loadData(filename, bundle: bundle)
    }
}
