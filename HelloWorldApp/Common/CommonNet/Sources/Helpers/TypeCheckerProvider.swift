//
//  TypeCheckerProvider.swift
//  CommonNet
//
//  Created by Anton Vlezko on 20/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI

protocol TypeCheckerProviderProtocol {
    func typeName(of subject: Any) -> String
    func reflect(_ type: Any.Type) -> ReflectedType
}

// MARK: - TypeCheckerProvider

public class TypeCheckerProvider {

    // MARK: - Properties

    static public let shared = TypeCheckerProvider()
    let fatalErrorWithTypeProvider = FatalErrorWithTypeProvider.shared

    // MARK: Construction

    private init() {}
}

// MARK: - TypeCheckerProviderProtocol

extension TypeCheckerProvider: TypeCheckerProviderProtocol {
    public func typeName(of subject: Any) -> String {
        let type = (subject is Any.Type) ? subject : Swift.type(of: subject)

        return reflect(type as! any Any.Type).name
    }

    public func reflect(_ type: Any.Type) -> ReflectedType {
        let root = split(fullName: String(reflecting: type), maxDepth: 1)
        var node = root

        let isOptional = self.isOptional(root)
        let isImplicitlyUnwrappedOptional = self.isImplicitlyUnwrappedOptional(root)

        if (isOptional || isImplicitlyUnwrappedOptional) {
            if let child = root.child {
                node = child
            }
        }

        let (simpleName, canonicalName) = normalizeName(node)
        return ReflectedType(
            name: simpleName,
            fullName: canonicalName,
            isOptional: isOptional,
            isImplicitlyUnwrappedOptional: isImplicitlyUnwrappedOptional,
            isProtocol: isProtocol(node)
        )
    }
}

// MARK: - Private Methods

fileprivate extension TypeCheckerProvider {
    func split(fullName: String, maxDepth: UInt = UInt.max) -> MetatypeNode {
        var wrappedName = Substring(fullName)
        var names = [String]()

        // Split names of Types
        for _ in 0..<maxDepth {
            if let from = wrappedName.firstIndex(of: "<"), let upto = wrappedName.firstIndex(of: ">") {

                // Extract name of wrapped type
                names.append("\(wrappedName[...from])T\(wrappedName[upto...])")
                wrappedName = wrappedName[wrappedName.index(after: from)..<upto]
            } else {
                break
            }
        }

        // Build linked list of MetatypeNodes
        var node = MetatypeNode(value: String(wrappedName), child: nil)
        for name in names.reversed() {
            node = MetatypeNode(value: name, child: node)
        }

        // Done
        return node
    }

    func isOptional(_ node: MetatypeNode) -> Bool {
        return Constants.prefixOptionals.contains { node.value.hasPrefix($0) }
    }

    func isImplicitlyUnwrappedOptional(_ node: MetatypeNode) -> Bool {
        return Constants.prefixImplicitlyUnwrappedOptionals.contains { node.value.hasPrefix($0) }
    }

    func isProtocol(_ node: MetatypeNode) -> Bool {
        return Constants.suffixProtocols.contains { node.value.hasSuffix($0) }
    }

    func normalizeName(_ node: MetatypeNode) -> (simpleName: String, canonicalName: String) {
        // Build canonical name of Type
        var canonicalName = ""

        Swift.sequence(first: node, next: { $0.child }).reversed().forEach {
            let value = normalize(name: $0.value)

            if (canonicalName.isEmpty) {
                canonicalName = value
            } else if let range = value.range(of: "<T>") {
                canonicalName = value.replacingCharacters(in: range, with: "<\(canonicalName)>")
            } else {
                fatalErrorWithTypeProvider.fatalErrorWithType(
                    "Invalid state. Value ‘\(value)’ does not contains placeholder ‘<T>’.",
                    file: #file,
                    line: #line
                )
            }
        }

        // Extract simple name of Type
        var startIndex = canonicalName.startIndex
        var char: Character = "?" // dummy

        for index in canonicalName.indices {
            char = canonicalName[index]

            if char == "." {
                startIndex = canonicalName.index(after: index)
            } else if char == "<" {
                break
            }
        }

        // Done
        return (String(canonicalName[startIndex...]), canonicalName)
    }

    func normalize(name: String) -> String {
        return name
    }
}

// MARK: - Inner Types

fileprivate extension TypeCheckerProvider {
    
    class MetatypeNode {

        // MARK:  Properties

        let value: String
        let child: MetatypeNode?

        // MARK:  Construction

        init(
            value: String,
            child: MetatypeNode? = nil
        ) {
            // Init instance
            self.value = value
            self.child = child
        }
    }
}

// MARK: - Constants

fileprivate extension TypeCheckerProvider {
    enum Constants {
       static let prefixImplicitlyUnwrappedOptionals = [
           "Swift.ImplicitlyUnwrappedOptionals<",
           "ImplicitlyUnwrappedOptionals<"
       ]
       static let prefixOptionals = [
           "Swift.Optional<",
           "Optional<"
       ]
       static let suffixProtocols = [
           ".Protocol"
       ]
   }
}
