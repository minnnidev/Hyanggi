//
//  ImageFileManager.swift
//  Hyanggi
//
//  Created by 김민 on 6/3/24.
//

import Foundation
import UIKit

final class ImageFileManager {

    static let shared = ImageFileManager()
    private let appPath = "Hyanggi_Images"

    private init() {
        createDirectoryIfNeeded()
    }

    func saveImage(image: UIImage, imageName: String) {
        guard let data = image.pngData(), let path = getPathForImage(imageName: imageName) else { return }

        do {
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadImage(imageName: String) -> UIImage? {
        guard let path = getPathForImage(imageName: imageName)?.path, FileManager.default.fileExists(atPath: path) else {
            return nil
        }

        return UIImage(contentsOfFile: path)
    }

    func deleteImage(imageName: String) {
        guard let path = getPathForImage(imageName: imageName), FileManager.default.fileExists(atPath: path.path) else {
            return
        }

        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print(error.localizedDescription)
        }
    }

    func getPathForImage(imageName: String) -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(appPath)
                .appendingPathComponent("\(imageName).png") else { return nil }
        return path
    }

    func createDirectoryIfNeeded() {
        guard let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(appPath)
                .path else { return }

        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
