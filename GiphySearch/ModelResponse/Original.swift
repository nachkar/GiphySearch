//
//  Original.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Original: JSONCompatible {
    var height: String
    var mp4_size: String
    var mp4: String
    var webp_size: String
    var width: String
    var webp: String
    var frames: String
    var size: String
    var hash: String
    var url: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        height = json["height"] as? String ?? ""
        mp4_size = json["mp4_size"] as? String ?? ""
        mp4 = json["mp4"] as? String ?? ""
        webp_size = json["webp_size"] as? String ?? ""
        width = json["width"] as? String ?? ""
        webp = json["webp"] as? String ?? ""
        frames = json["frames"] as? String ?? ""
        size = json["size"] as? String ?? ""
        hash = json["hash"] as? String ?? ""
        url = json["url"] as? String ?? ""
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(height: String, mp4_size: String, mp4: String, webp_size: String, width: String, webp: String, frames: String, size: String, hash: String, url: String) {
        self.height = height
        self.mp4_size = mp4_size
        self.mp4 = mp4
        self.webp_size = webp_size
        self.width = width
        self.webp = webp
        self.frames = frames
        self.size = size
        self.hash = hash
        self.url = url
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["height"] = height
        dict["mp4_size"] = mp4_size
        dict["mp4"] = mp4
        dict["webp_size"] = webp_size
        dict["width"] = width
        dict["webp"] = webp
        dict["frames"] = frames
        dict["size"] = size
        dict["hash"] = hash
        dict["url"] = url
        return dict
    }

}
