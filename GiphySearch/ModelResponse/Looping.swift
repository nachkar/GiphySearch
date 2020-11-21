//
//  Looping.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Looping: JSONCompatible {
    var mp4: String
    var mp4_size: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        mp4 = json["mp4"] as? String ?? ""
        mp4_size = json["mp4_size"] as? String ?? ""
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(mp4: String, mp4_size: String) {
        self.mp4 = mp4
        self.mp4_size = mp4_size
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["mp4"] = mp4
        dict["mp4_size"] = mp4_size
        return dict
    }

}
