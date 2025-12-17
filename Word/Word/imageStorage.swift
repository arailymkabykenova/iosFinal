//
//  imageStorage.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import UIKit

final class ImageStorage {

    static let shared = ImageStorage()
    private init() {}

    func save(image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }

        let fileName = UUID().uuidString + ".jpg"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)

        try? data.write(to: url)
        return fileName
    }

    func load(imageName: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(imageName)

        return UIImage(contentsOfFile: url.path)
    }
}
