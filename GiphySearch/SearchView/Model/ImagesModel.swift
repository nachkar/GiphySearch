//
//  ImagesModel.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

class ImagesModel: NSObject {
    
    typealias CompletionHandler = (_ success: Bool, _ message: String, _ result: [DataItem]) -> Void
    func getTrendings(completionHandler : @escaping CompletionHandler) {
        
        //HttpRequest
        let urlString = "\(ServerAddress.BaseUrl)\(ServerAddress.TrendingApi)"
        
        let httpRequest = HTTPRequest.init()
        httpRequest.GET(requestUrl: urlString, success: { (response: Any)  in
            if response is NSDictionary {
                print("Giphy Images "+"\(response)")
                
                let result = GiphyResponse.init(json: response as? Dictionary)
                if result != nil {
                    if result?.meta.status == 200 {
                        completionHandler(true, result?.meta.msg ?? "", result!.data)
                    } else {
                        completionHandler(false, result?.meta.msg ?? "Constants.Values.ErrorText", [])
                    }
                } else {
                    completionHandler(false, result?.meta.msg ?? "Constants.Values.ErrorText", [])
                }
            } else {
                completionHandler(false, "Constants.Values.ErrorText", [])
            }
        }, failure: {() in
            completionHandler(false, "Constants.Values.ErrorText", [])
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
