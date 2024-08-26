//
//  KeychainStorageService.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//
import Foundation

final class KeychainStorageService: KeychainStorage {
    // MARK: Keys

    private enum Keys {
        static let authenticationCredential = "authentication_credential"
    }

    var authenticationCredential: OAuthCredential? {
        get throws {
            try item(forKey: Keys.authenticationCredential)
        }
    }

    func set(_ authenticationCredential: OAuthCredential?) throws {
        try save(authenticationCredential, for: Keys.authenticationCredential)
    }

    // MARK: Read data

    private func item<Item: Decodable>(forKey key: String) throws -> Item {
        let data = try data(for: key)
        return try JSONDecoder().decode(Item.self, from: data)
    }

    private func data(for key: String) throws -> Data {
        // Build a query to find the item that matches the service and key.
        var query = query(for: key)
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnAttributes] = kCFBooleanTrue
        query[kSecReturnData] = kCFBooleanTrue

        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else {
            throw KeychainStorageError.itemNotFound
        }
        guard status == noErr else {
            throw KeychainStorageError.invalidStatus(status)
        }

        // Parse the data from the query result.
        guard
            let existingItem = queryResult as? [CFString: AnyObject],
            let data = existingItem[kSecValueData] as? Data
        else {
            throw KeychainStorageError.invalidData
        }

        return data
    }

    private func containsItem(for key: String) throws {
        try _ = data(for: key)
    }

    // MARK: Write data

    private func save<Item: Encodable>(_ item: Item?, for key: String) throws {
        if let item = item {
            let data = try JSONEncoder().encode(item)
            try save(data, for: key)
        } else {
            try deleteItem(for: key)
        }
    }

    private func save(_ data: Data, for key: String) throws {
        do {
            // Check for an existing item in the keychain.
            try containsItem(for: key)

            // Update the existing item with the new password.
            var attributesToUpdate: [String: AnyObject] = [:]
            attributesToUpdate[kSecValueData as String] = data as AnyObject?

            let query = query(for: key)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else {
                throw KeychainStorageError.invalidStatus(status)
            }
        } catch KeychainStorageError.itemNotFound {
            /*
             No data was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = query(for: key)
            newItem[kSecValueData] = data as AnyObject?

            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else {
                throw KeychainStorageError.invalidStatus(status)
            }
        }
    }

    // MARK: Delete data

    private func deleteItem(for key: String) throws {
        // Delete the existing item from the keychain.
        let query = query(for: key)
        let status = SecItemDelete(query as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainStorageError.invalidStatus(status)
        }
    }

    // MARK: Query

    private func query(
        for key: String
    ) -> [CFString: AnyObject] {
        var query: [CFString: AnyObject] = [:]
        query[kSecClass] = kSecClassGenericPassword
        query[kSecAttrService] = Bundle.main.bundleIdentifier as AnyObject?
        query[kSecAttrAccount] = key as AnyObject?
        query[kSecAttrAccessible] = kSecAttrAccessibleWhenUnlocked
        return query
    }
}

