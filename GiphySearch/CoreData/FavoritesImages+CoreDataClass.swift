//
//  FavoritesImages+CoreDataClass.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation
import CoreData

@objc(FavoritesImages)
public class FavoritesImages: NSManagedObject {

    class func insertImage(_ model: ImagesCellViewModelItem, in context: NSManagedObjectContext) -> FavoritesImages {
        var imageData = FavoritesImages.getImage(imageId: model.imageId, inMoc: context)

        if imageData == nil {
            imageData = NSEntityDescription.insertNewObject(forEntityName: "FavoritesImages", into: context) as? FavoritesImages
            imageData?.imageId = model.imageId
            imageData?.imageUrl = model.imageUrl
            imageData?.imageSource = model.imageSource
            imageData?.imageLbl = model.imageTitle
            imageData?.imageRating = model.imageRating
        }

        return imageData!
    }

    class func removeImage(_ imageId: String, in context: NSManagedObjectContext) {
        let imageData = FavoritesImages.getImage(imageId: imageId, inMoc: context)

        guard let image = imageData else {
            return
        }

        context.delete(image)
    }

    class func getImage(imageId: String, inMoc context: NSManagedObjectContext) -> FavoritesImages? {
        let entityName: String = NSStringFromClass(FavoritesImages.self)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "imageId = %@", imageId)
        fetchRequest.predicate = predicate
        fetchRequest.entity = entity
        fetchRequest.includesPendingChanges = true
        fetchRequest.fetchLimit = 1
        let results = try? context.fetch(fetchRequest)

        return results?.last as? FavoritesImages
    }
}
