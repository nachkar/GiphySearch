//
//  Analytics.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Analytics: JSONCompatible {
    var onclick: Onclick
    var onsent: Onsent
    var onload: Onload

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        onclick = Onclick(json: json["onclick"] as? [String: Any]) ?? Onclick()
        onsent = Onsent(json: json["onsent"] as? [String: Any]) ?? Onsent()
        onload = Onload(json: json["onload"] as? [String: Any]) ?? Onload()
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(onclick: Onclick, onsent: Onsent, onload: Onload) {
        self.onclick = onclick
        self.onsent = onsent
        self.onload = onload
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["onclick"] = onclick.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["onsent"] = onsent.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["onload"] = onload.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        return dict
    }

}
