//
//  FavoritesViewModel.swift
//  GiphySearch
//
//  Created by Noel Achkar on 23/11/2020.
//

import UIKit

class FavoritesViewModel: NSObject {

    var favModel = FavoritesModel()

    func initialise() {

        favModel.setupListContentFavorites(completionHandler: { [weak self] result in
            self?.processFetchedData(data: result)
        })

        favModel.fetchedResultsUpdated = { [weak self] type, result  in
            switch type {
            case .willBegin:
                self?.willBeginUpdate?()
                break
            case .didFinish:
                self?.processFetchedData(data: result as! [FavoritesImages])
                self?.didFinishUpdate?()
                break
            }
        }

        favModel.fetchedResultsRowUpdated = { [weak self] type, result, indexPath, newIndexPath in
            self?.didChangeRow?(type, indexPath, newIndexPath)
        }

        favModel.fetchedResultsSectionUpdated = { [weak self] type, sectionIndex in
            self?.didChangeSection?(type, sectionIndex)
        }
    }

    func removeFavorite(imageId: String) {
        favModel.removeImageFavorite(imageId: imageId)
    }

    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?(isLoading) }
    }

    var error: String? {
        didSet { self.showAlertClosure?() }
    }

    var didFinishLoading: ((_ images: [FavoritesCellViewModelItem]) -> Void)?
    var updateLoadingStatus: ((_ isLoading: Bool) -> Void)?
    var showAlertClosure: (() -> Void)?

    var itemCount: Int {
        get { return self.items.count }
    }

    func createCellViewModel(image: FavoritesImages) -> FavoritesCellViewModelItem {
        return FavoritesCellViewModelItem(imageId: image.imageId!, imageUrl: image.imageUrl ?? "", imageTitle: image.imageLbl ?? "", imageRating: image.imageRating ?? "", imageSource: image.imageSource ?? "")
    }

    func processFetchedData(data: [FavoritesImages]) {
        var vms = [FavoritesCellViewModelItem]()

        for item in data {
            vms.append(createCellViewModel(image: item))
        }
        self.items = vms
    }

    var items: [FavoritesCellViewModelItem] = [] {
        didSet { self.didFinishLoading?(self.items) }
    }
    //

    var willBeginUpdate: (() -> Void)?
    var didFinishUpdate: (() -> Void)?
    var didChangeRow: ((_ type: FetchedResultsChangeType, _ indexPath: IndexPath?, _ newIndexPath: IndexPath?) -> Void)?
    var didChangeSection: ((_ type: FetchedResultsChangeType, _ sectionIndex: Int) -> Void)?
}

struct FavoritesCellViewModelItem {
    var imageId: String
    var imageUrl: String
    var imageTitle: String
    var imageRating: String
    var imageSource: String
}
