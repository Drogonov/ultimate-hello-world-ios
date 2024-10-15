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

open class ConversionError: Error {
// MARK: - Construction

    /// Initializes and returns a newly created error object.
    ///
    /// - Parameters:
    ///   - reason: A human-readable message string summarizing the reason for the exception.
    ///   - JSON: A dictionary containing JSON data.
    ///   - cause: The error that is the cause of the current error, or a `nil` reference if no cause is specified.
    ///
    public init(reason: String? = nil, JSON: [String: Any]? = nil, cause: Error? = nil) {

        // Init instance
        self.reason = reason
        self.JSON = JSON
        self.cause = cause
    }

// MARK: - Properties

    /// A human-readable message string summarizing the reason for the error.
    public let reason: String?

    /// A dictionary containing JSON data.
    public let JSON: [String: Any]?

    public let cause: Error?
}

// ----------------------------------------------------------------------------


public enum JsonLoaderError: LocalizedError {
    case emptyName
    case notLoad(String)
    case notParse(String, ConversionError?)

    public var description: String {
        switch self {
        case .emptyName:
            return "‘filename’ is empty"
        case .notLoad(let filename):
            return "Could not load file: \(filename).json"
        case let .notParse(filename, error):
            var string = "Could not parse JSON from file: \(filename).json"
            if let error = error?.reason {
                string = "\(string). Error: \(error)"
            }
            return string
        }
    }
}

public protocol ResponseConverterProtocol {

    func convert(object: Any?) throws -> T

    associatedtype T
}

// ----------------------------------------------------------------------------


open class AbstractCallResultConverter<T>: ResponseConverterProtocol {
// MARK: - Construction

    public init() {
        // Do nothing
    }

// MARK: - Methods

    public func convert(object: Any?) throws -> T {
        fatalError("Must be overrided")
    }
}

// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------

// Use this protocol instead of MapContext protocol to prevent import ObjectMapper in places of use
public protocol AbstractMapContext: MapContext {
    // Add needed properties in subclasses
}

// ----------------------------------------------------------------------------


open class AbstractValidatableModelArrayConverter<U: BaseResponse>: AbstractCallResultConverter<[U]> {
// MARK: - Construction

    public init(keyPath: String? = nil, context: AbstractMapContext? = nil) {
        self.keyPath = keyPath
        self.context = context

        super.init()
    }

// MARK: - Methods

    open override func convert(object: Any?) throws -> [U] {
        let newBody: [U]

        do {
            // Try to parse response body as JSON array
            var jsonObjects: Any?
            if let keyPath = self.keyPath {
                jsonObjects = (object as? [String: Any])?[keyPath]
            } else {
                jsonObjects = object
            }
            if let jsonObjects = jsonObjects as? [Any] {
                newBody = try jsonObjects.map { (element) in
                    if let jsonObject = element as? [String: Any] {
                        return try U(JSON: jsonObject, context: context)
                    } else {
                        throw ConversionError(reason: "Failed to convert element of array[\(String(describing: index))] to JSON object.")
                    }
                }
            } else {
                throw ConversionError(reason: "Failed to convert response body to JSON array.")
            }
        } catch {
            throw ConversionError(cause: error)
        }

        return newBody
    }

// MARK: - Variables

    private let keyPath: String?
    private let context: AbstractMapContext?
}

// ----------------------------------------------------------------------------


open class AbstractValidatableModelConverter<U: BaseResponse>: AbstractCallResultConverter<U> {
// MARK: - Construction

    public init(keyPath: String? = nil, context: AbstractMapContext? = nil) {
        self.keyPath = keyPath
        self.context = context
        super.init()
    }

// MARK: - Methods

    open override func convert(object: Any?) throws -> T {
        let newBody: U

        do {
            // Try to parse response body as JSON object
            var jsonObject: Any?
            if let keyPath = self.keyPath {
                jsonObject = (object as? [String: Any])?[keyPath]
            } else {
                jsonObject = object
            }
            if let jsonObject = jsonObject as? [String: Any] {
                newBody = try U(JSON: jsonObject, context: context)
            } else if let jsonObject = jsonObject, jsonObject is NSNull {
                // Handle empty body
                let emptyJsonObject = [String: Any]()
                newBody = try U(JSON: emptyJsonObject, context: context)
            } else {
                throw ConversionError(reason: "Failed to convert response body to JSON object.")
            }
        } catch {
            throw ConversionError(cause: error)
        }

        return newBody
    }

// MARK: - Variables

    private let keyPath: String?
    private let context: AbstractMapContext?
}

// ----------------------------------------------------------------------------



// Used in tests
// periphery:ignore
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

public final class BundlesService {

    public static let shared = BundlesService()

    private init() {
        loadAllBundles()
    }

    public func bundleForClass(_ aClass: AnyClass) -> Bundle? {
        var result: Bundle?

        let resourceName = TypeCheckerProvider.shared.typeName(of: aClass).components(separatedBy: "<").first!

        result = bundleForResourceName(resourceName)

        return result
    }

    // Find bundle for resource with given name (don't pass extension)
    public func bundleForResourceName(_ resourceName: String) -> Bundle? {
        bundlesContent.first(where: { $0.value.contains(resourceName) })?.key
    }

    // Cache bundles and its content on first call
    private func loadAllBundles() {
        let url = Bundle.main.privateFrameworksURL!

        let fileManager = FileManager.default
        let bundlesURLS = try? fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsSubdirectoryDescendants])

        bundlesURLS?
            .compactMap { Bundle(url: $0) }
            .forEach { extractContentFileNames(in: $0) }

        extractContentFileNames(in: Bundle.main)
    }

    private func extractContentFileNames(in bundle: Bundle?) {
        guard let bundle = bundle else {
            return
        }

        let pathContents = try? FileManager.default.contentsOfDirectory(
            at: bundle.bundleURL,
            includingPropertiesForKeys: [.isRegularFileKey],
            options: [.skipsSubdirectoryDescendants]
        )

        let fileNames = pathContents?.compactMap { $0.deletingPathExtension().lastPathComponent } ?? []
        bundlesContent[bundle] = Set(fileNames)
    }

    private var bundlesContent = [Bundle.main: Set<String>()]
}


extension JsonLoader {

    public static func loadData(filename: String) throws -> Data {
        let bundle = BundlesService.shared.bundleForResourceName(filename)
        return try loadData(filename: filename, bundle: bundle)
    }
}

public class TestUtils {

    public enum Constants {
        public enum numbers {
            public static let waitTimeInterval: TimeInterval = 10
        }
    }

    // MARK: - Construction

    public static let shared = TestUtils()

    private init() {}

    // MARK: - Methods

    public func loadObjectFromJson<T: BaseResponse>(filename: String, bundle: Bundle?) -> T {
        var item: T?
        do {
            item = try JsonLoader.loadObject(filename: filename, bundle: bundle)
        } catch let error as JsonLoaderError {
            errorHandler(error, filename: filename)
        } catch {
        }
        return item!
    }

    public func loadObjectsFromJson<T: BaseResponse>(filename: String, bundle: Bundle?) -> [T] {
        var items: [T]?
        do {
            items = try JsonLoader.loadObjects(filename: filename, bundle: bundle)
        } catch let error as JsonLoaderError {
            errorHandler(error, filename: filename)
        } catch {
        }
        return items!
    }

    public func loadJson(_ filename: String, bundle: Bundle?) -> [String: Any] {
        var json: [String: Any]?
        do {
            json = try JsonLoader.loadJson(filename: filename, bundle: bundle) as? [String: Any]
        } catch let error as JsonLoaderError {
            errorHandler(error, filename: filename)
        } catch {
        }
        return json!
    }

    public func loadData(_ filename: String, bundle: Bundle?) -> Data {
        var data: Data?
        do {
            data = try JsonLoader.loadData(filename: filename, bundle: bundle)
        } catch let error as JsonLoaderError {
            errorHandler(error, filename: filename)
        } catch {
        }
        return data!
    }

    // MARK: - Private Methods

    private func errorHandler(_ error: JsonLoaderError, filename: String) {
        switch error {
        case .emptyName:
            XCTAssert(!filename.isEmpty, error.description)

        default:
            XCTFail(error.description)
        }
    }

    private func prefix(_ file: StaticString, _ line: UInt) -> String {
        let fileURL = URL(fileURLWithPath: String(describing: file))
        return "\(fileURL.lastPathComponent):\(line)"
    }

    // MARK: - Inner Types

    class FunctionCallsExpectation {
        private(set) var callsCount = 0
        var isCalledOnce: Bool { return callsCount == 1 }

        func call() {
            callsCount += 1
        }
    }

    class FunctionCallsExpectationWithData<T>: FunctionCallsExpectation {
        private(set) var data = [T]()

        func call(with data: T) {
            call()
            self.data.append(data)
        }
    }
}

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
