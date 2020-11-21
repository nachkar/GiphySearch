//
//  Downsized.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Downsized: JSONCompatible {
    var size: String
    var height: String
    var url: String
    var width: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        size = json["size"] as? String ?? ""
        height = json["height"] as? String ?? ""
        url = json["url"] as? String ?? ""
        width = json["width"] as? String ?? ""
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(size: String, height: String, url: String, width: String) {
        self.size = size
        self.height = height
        self.url = url
        self.width = width
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["size"] = size
        dict["height"] = height
        dict["url"] = url
        dict["width"] = width
        return dict
    }

}
