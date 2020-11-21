//
//  Meta.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Meta: JSONCompatible {
    var status: Int
    var response_id: String
    var msg: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        status = json["status"] as? Int ?? 0
        response_id = json["response_id"] as? String ?? ""
        msg = json["msg"] as? String ?? ""
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(status: Int, response_id: String, msg: String) {
        self.status = status
        self.response_id = response_id
        self.msg = msg
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["status"] = status
        dict["response_id"] = response_id
        dict["msg"] = msg
        return dict
    }

}
