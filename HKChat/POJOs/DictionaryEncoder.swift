//
//  DictionaryEncoder.swift
//  HKChat
//
//  Created by Hassan Khamis on 6/30/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation

struct DictionaryEncoder {
    static func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let jsonData = try JSONEncoder().encode(value)
        return try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
    }
}
