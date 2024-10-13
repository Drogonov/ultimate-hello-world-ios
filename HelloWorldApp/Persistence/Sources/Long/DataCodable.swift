//
//  DataCodable.swift
//  Persistence
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public protocol DataCodable {
    static func decode(_ data: Data) -> Self?
    func encode() -> String?
}

extension DataCodable where Self: Decodable {

    static public func decode(_ data: Data) -> Self? {
        do {
            let result: Self = try JSONDecoder().decode(Self.self, from: data)
            return result
        } catch {
            debugPrint("Error")
            return nil
        }
    }
}

extension DataCodable where Self: Encodable {

    public func encode() -> String? {
        guard let data = try? JSONEncoder().encode(self),
            let encodedString = String(data: data, encoding: .utf8) else {
                return nil
        }

        return encodedString
    }
}

extension String: DataCodable {
    // ...
}

extension Bool: DataCodable {
    // ...
}
