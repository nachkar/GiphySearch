//
//  CoreDataManager.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

private let shared = CoreDataManager()

@objc class CoreDataManager: CoreDataStorage {
    @objc class var sharedManager: CoreDataManager {
        return shared
    }

    func removeImage(imageId: String) {
        self.executeBlock(block: { context in
            FavoritesImages.removeImage(imageId, in: context)
        })
    }
    
    func insertFavorite(imageModel : ImagesCellViewModelItem) {
        self.scheduleBlock(block: {context in
            _ = FavoritesImages.insertImage(imageModel, in: context)
        })
    }
}
