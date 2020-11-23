//
//  FavoritesModel.swift
//  GiphySearch
//
//  Created by Noel Achkar on 23/11/2020.
//

import UIKit
import CoreData

class FavoritesModel: NSObject {

    var fetchedResultsControllerItems: NSFetchedResultsController<FavoritesImages>?

    typealias ResultHandlerItems = (_ result: [FavoritesImages]) -> Void
    func setupListContentFavorites(completionHandler : @escaping ResultHandlerItems) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoritesImages")

        let sortDescriptor = NSSortDescriptor(key: "imageId", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsControllerItems = NSFetchedResultsController(fetchRequest: fetchRequest as! NSFetchRequest<FavoritesImages>, managedObjectContext: CoreDataManager.sharedManager.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsControllerItems?.delegate = self

        do {
            try fetchedResultsControllerItems?.performFetch()
        } catch {
            print("error: \(error)")
            return
        }

        completionHandler((fetchedResultsControllerItems?.fetchedObjects)!)
    }

    func removeImageFavorite(imageId: String) {
        CoreDataManager.sharedManager.removeImage(imageId: imageId)
    }

    var fetchedResultsUpdated: ((_ type: FetchedResultUpdate, _ result: [NSFetchRequestResult]) -> Void)?
    var fetchedResultsRowUpdated: ((_ type: FetchedResultsChangeType, _ result: [NSFetchRequestResult], _ indexPath: IndexPath?, _ newIndexPath: IndexPath?) -> Void)?
    var fetchedResultsSectionUpdated: ((_ type: FetchedResultsChangeType, _ sectionIndex: Int) -> Void)?
}

extension FavoritesModel: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchedResultsUpdated!(.willBegin, controller.fetchedObjects!)
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchedResultsUpdated!(.didFinish, controller.fetchedObjects!)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        fetchedResultsRowUpdated!(FetchedResultsChangeType(rawValue: type.rawValue)!, controller.fetchedObjects!, indexPath, newIndexPath)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        fetchedResultsSectionUpdated!(FetchedResultsChangeType(rawValue: type.rawValue)!, sectionIndex)
    }
}
