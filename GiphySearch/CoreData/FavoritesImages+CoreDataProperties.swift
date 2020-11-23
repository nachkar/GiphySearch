//
//  FavoritesImages+CoreDataProperties.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//
//

import Foundation
import CoreData

extension FavoritesImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesImages> {
        return NSFetchRequest<FavoritesImages>(entityName: "FavoritesImages")
    }

    @NSManaged public var imageId: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var imageRating: String?
    @NSManaged public var imageSource: String?
    @NSManaged public var imageLbl: String?
}

extension FavoritesImages: Identifiable {

}
