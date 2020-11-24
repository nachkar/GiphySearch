//
//  ImagesViewModel.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

class ImagesViewModel: NSObject {

    var dataArray: [DataItem]?
    var searchText = ""
    var imagesModel = ImagesModel()

    func initialise() {
        self.getTrendings(isLoadMore: false)
    }

    func getTrendings(isLoadMore: Bool) {
        self.isLoading = true

        imagesModel.getTrendings(offset: isLoadMore ? "\(itemCount+1)" : "0", completionHandler: { [weak self] success, message, result in
            self?.isLoading = false

            if success {
                if isLoadMore {
                    self?.dataArray?.append(contentsOf: result)
                } else {
                    self?.dataArray = result
                }

                self?.processFetchedData(data: result, isLoadMore: isLoadMore)
                self?.success = message
            } else {
                self?.error = message
            }
        })
    }

    func filterData(text: String, isLoadMore: Bool) {
        self.searchText = text
        self.isLoading = true

        imagesModel.searchImages(text: text, offset: isLoadMore ? "\(itemCount+1)" : "0", completionHandler: { [weak self] success, message, result in
            self?.isLoading = false

            if success {
                self?.processFetchedData(data: result, isLoadMore: isLoadMore)
                self?.success = message
            } else {
                self?.error = message
            }
        })
    }

    //On removing favorite from FavoritesViewController
    func reloadFavData(imageId: String) {
        let data = self.items.filter { $0.imageId == imageId }
        if let image = data.first {
            image.isFavorite = false
            self.finishedLoading = true
        }
    }

    func loadMoreData(status: ImagesStatus) {
        switch status {
        case .searching:
            filterData(text: self.searchText, isLoadMore: true)
            break
        case .trending:
            getTrendings(isLoadMore: true)
        break
        }
    }

    func cancelFilter() {
        self.processFetchedData(data: self.dataArray!, isLoadMore: false)
    }

    func updateImageState(image: ImagesCellViewModelItem) {
        imagesModel.updateImageState(image: image)
    }

    var finishedLoading: Bool = false {
        didSet { self.didFinishLoading?() }
    }

    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?(isLoading) }
    }

    var error: String? {
        didSet { self.showAlertClosure?() }
    }
    var success: String? {
        didSet { self.showSuccessClosure?() }
    }

    var itemCount: Int {
        get {  return items.count }
    }

    var items: [ImagesCellViewModelItem] = [] {
        didSet { self.finishedLoading = true }
    }

    func createCellViewModel(item: DataItem) -> ImagesCellViewModelItem {
        return ImagesCellViewModelItem(imageId: item.id, imageUrl: item.images.fixed_width_small.url, imageTitle: item.title, imageRating: item.rating, imageSource: item.source_tld, isFavorite: imagesModel.getIsFavorite(imageId: item.id))
        }

    func processFetchedData(data: [DataItem], isLoadMore: Bool) {
        var vms = isLoadMore ? self.items : [ImagesCellViewModelItem]()

        for image in data {
            vms.append(createCellViewModel(item: image))
        }

        self.items = vms
    }

    var showSuccessClosure: (() -> Void)?
    var didFinishLoading: (() -> Void)?
    var updateLoadingStatus: ((_ isLoading: Bool) -> Void)?
    var showAlertClosure: (() -> Void)?
}

class ImagesCellViewModelItem: NSObject {
    var imageId: String
    var imageUrl: String
    var imageTitle: String
    var imageRating: String
    var imageSource: String
    var isFavorite: Bool

    init(imageId: String, imageUrl: String, imageTitle: String, imageRating: String, imageSource: String, isFavorite: Bool) {
        self.imageId = imageId
        self.imageUrl = imageUrl
        self.imageTitle = imageTitle
        self.imageRating = imageRating
        self.imageSource = imageSource
        self.isFavorite = isFavorite
    }
}
