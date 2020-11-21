//
//  Pagination.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Pagination: JSONCompatible {
    var offset: Int
    var total_count: Int
    var count: Int

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        offset = json["offset"] as? Int ?? 0
        total_count = json["total_count"] as? Int ?? 0
        count = json["count"] as? Int ?? 0
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(offset: Int, total_count: Int, count: Int) {
        self.offset = offset
        self.total_count = total_count
        self.count = count
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["offset"] = offset
        dict["total_count"] = total_count
        dict["count"] = count
        return dict
    }

}
