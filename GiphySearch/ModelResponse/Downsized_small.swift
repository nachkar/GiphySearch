//
//  Downsized_small.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Downsized_small: JSONCompatible {
    var height: String
    var mp4: String
    var mp4_size: String
    var width: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        height = json["height"] as? String ?? ""
        mp4 = json["mp4"] as? String ?? ""
        mp4_size = json["mp4_size"] as? String ?? ""
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

    init(height: String, mp4: String, mp4_size: String, width: String) {
        self.height = height
        self.mp4 = mp4
        self.mp4_size = mp4_size
        self.width = width
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["height"] = height
        dict["mp4"] = mp4
        dict["mp4_size"] = mp4_size
        dict["width"] = width
        return dict
    }

}
