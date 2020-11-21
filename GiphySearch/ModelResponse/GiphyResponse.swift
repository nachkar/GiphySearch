//
//  GiphyResponse.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct GiphyResponse: JSONCompatible {
    var pagination: Pagination
    var meta: Meta
    var data: [DataItem]

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        pagination = Pagination(json: json["pagination"] as? [String: Any]) ?? Pagination()
        meta = Meta(json: json["meta"] as? [String: Any]) ?? Meta()
        data = (json["data"] as? [[String: Any]] ?? []).compactMap {DataItem(json: $0)}
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(pagination: Pagination, meta: Meta, data: [DataItem]) {
        self.pagination = pagination
        self.meta = meta
        self.data = data
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["pagination"] = pagination.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["meta"] = meta.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["data"] = data.map {$0.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)}
        return dict
    }

}
