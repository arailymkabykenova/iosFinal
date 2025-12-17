//
//  Storage.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import Foundation

final class Storage {

    static let shared = Storage()
    private init() {}

    private let key = "checked_words"

    func save(_ items: [CheckedWord]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [CheckedWord] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        let decoder = JSONDecoder()
        return (try? decoder.decode([CheckedWord].self, from: data)) ?? []
    }
}
