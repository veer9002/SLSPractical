//
//  StorageManager.swift
//  ImageBase64
//
//  Created by Manish Sharma on 05/03/20.
//  Copyright © 2020 Manish Sharma. All rights reserved.
//

import Foundation
import UIKit

class StorageManager  {
    
    static let shared = StorageManager()
    
    func store(image: UIImage,
                       forKey key: String,
                       withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving results in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation,
                                          forKey: key)
            }
        }
    }
    
     func retrieveImage(forKey key: String,
                               inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return nil
    }
    
     func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else {
                                                    return nil
        }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    @objc
    func save() {
        if let buildingImage = UIImage(named: "building") {
            DispatchQueue.global(qos: .background).async {
                self.store(image: buildingImage,
                           forKey: "buildingImage",
                           withStorageType: .fileSystem)
            }
        }
    }
    
    @objc
     func display(imgView: UIImageView) {
        DispatchQueue.global(qos: .background).async {
            if let savedImage = self.retrieveImage(forKey: "buildingImage",
                                                   inStorageType: .fileSystem) {
                DispatchQueue.main.async {
                    imgView.image = savedImage
                }
            }
        }
    }
    
}
