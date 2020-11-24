//
//  ImagesModel.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

class ImagesModel: NSObject {

    typealias CompletionHandler = (_ success: Bool, _ message: String, _ result: [DataItem]) -> Void
    func getTrendings(offset: String = "0", completionHandler : @escaping CompletionHandler) {

        //HttpRequest
        let urlString = "\(ServerAddress.BaseUrl)\(ServerAddress.TrendingApi)&offset=\(offset)"

        let httpRequest = HTTPRequest.init()
        httpRequest.GET(requestUrl: urlString, success: { (response: Any)  in
            if response is NSDictionary {
                print("Giphy Trendings "+"\(response)")

                let result = GiphyResponse.init(json: response as? Dictionary)
                if result != nil {
                    if result?.meta.status == 200 {
                        completionHandler(true, result?.meta.msg ?? "", result!.data)
                    } else {
                        completionHandler(false, result?.meta.msg ?? "Error", [])
                    }
                } else {
                    completionHandler(false, result?.meta.msg ?? "Error", [])
                }
            } else {
                completionHandler(false, "Error", [])
            }
        }, failure: {() in
            completionHandler(false, "Error", [])
        })
    }

    typealias SearchHandler = (_ success: Bool, _ message: String, _ result: [DataItem]) -> Void
    func searchImages(text: String, offset: String = "0", completionHandler : @escaping SearchHandler) {
        //HttpRequest
        let urlString = "\(ServerAddress.BaseUrl)\(ServerAddress.SearchApi)&q=\(text)&offset=\(offset)"

        let httpRequest = HTTPRequest.init()
        httpRequest.GET(requestUrl: urlString, success: { (response: Any)  in
            if response is NSDictionary {
                print("Giphy Search "+"\(response)")

                let result = GiphyResponse.init(json: response as? Dictionary)
                if result != nil {
                    if result?.meta.status == 200 {
                        completionHandler(true, result?.meta.msg ?? "", result!.data)
                    } else {
                        completionHandler(false, result?.meta.msg ?? "Error", [])
                    }
                } else {
                    completionHandler(false, result?.meta.msg ?? "Error", [])
                }
            } else {
                completionHandler(false, "Error", [])
            }
        }, failure: {() in
            completionHandler(false, "Error", [])
        })
    }

    func updateImageState(image: ImagesCellViewModelItem) {
        if image.isFavorite {
            CoreDataManager.sharedManager.removeImage(imageId: image.imageId)
        } else {
            CoreDataManager.sharedManager.insertFavorite(imageModel: image)
        }
    }

    func getIsFavorite(imageId: String) -> Bool {
        let image = CoreDataManager.sharedManager.getImage(imageId: imageId)
        if image != nil {
            return true
        }

        return false
    }
}
