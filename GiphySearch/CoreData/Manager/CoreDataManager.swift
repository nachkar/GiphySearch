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
}