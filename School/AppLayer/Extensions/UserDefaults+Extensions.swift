//
//  UserDefaults+Extensions.swift
//  School
//
//  Created by Mahmoud on 10/05/2025.
//

import Foundation
public extension UserDefaults {
    /// Saves a Codable object into UserDefaults with the specified key.
    /// - Parameters:
    ///   - object: The Codable object to be saved.
    ///   - key: The key under which to store the object in UserDefaults.
    func save<T: Encodable>(customObject object: T , inKey key: String) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(object) else {
            return
        }
        self.set(encoded, forKey: key)
    }
    /// Loads a Codable object from UserDefaults for the specified key.
    /// - Parameters:
    ///   - type: The type of the object to decode.
    ///   - key: The key used to retrieve the object from UserDefaults.
    /// - Returns: The decoded object of the specified type, or nil if decoding fails.
    func load<T: Decodable>(object type: T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    /// Resets UserDefaults keys associated with the specified array of keys.
    /// - Parameters:
    ///   - keys: An array of keys to reset in UserDefaults.
    ///   - completion: A completion closure to be executed after resetting the keys.
    func reset(keys: [String], _ completion: @escaping () -> Void) {
        keys.forEach { removeObject(forKey: $0) }
        completion()
    }
}
