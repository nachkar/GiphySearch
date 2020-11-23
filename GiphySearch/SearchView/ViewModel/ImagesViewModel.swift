//
//  ImagesViewModel.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

class ImagesViewModel: NSObject {

    var dataArray: [DataItem]?
    var imagesModel = ImagesModel()

    func initialise() {
        self.getTrendings()
    }

    func getTrendings() {
        self.isLoading = true

        imagesModel.getTrendings(completionHandler: { [weak self] success, message, result in
            self?.isLoading = false

            if success {
                self?.dataArray = result
                self?.processFetchedData(data: result)
                self?.success = message
            } else {
                self?.error = message
            }
        })
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
        return ImagesCellViewModelItem(imageId: item.id, imageUrl: item.images.fixed_width_small.url, imageTitle: item.title, imageRating: item.rating, imageSource: item.source_tld, isFavorite: false)
        }

    func processFetchedData(data: [DataItem]) {
        var vms = [ImagesCellViewModelItem]()

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

struct ImagesCellViewModelItem {
    var imageId: String
    var imageUrl: String
    var imageTitle: String
    var imageRating: String
    var imageSource: String
    var isFavorite: Bool
}