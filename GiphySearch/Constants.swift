//
//  Constants.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

public enum ServerAddress {
    static let BaseUrl = "https://api.giphy.com"
    static let SearchApi = "/v1/gifs/search?api_key=w9i1RABmCTFmeHetNMzCxiuMmjJqy5Cy&limit=25"
    static let TrendingApi = "/v1/gifs/trending?api_key=w9i1RABmCTFmeHetNMzCxiuMmjJqy5Cy&limit=25"
}

public enum FetchedResultUpdate {
    case willBegin
    case didFinish
}

public enum ImagesStatus {
    case searching
    case trending
}

public enum FetchedResultsChangeType: UInt {
    case insert = 1
    case delete = 2
    case move = 3
    case update = 4
}
