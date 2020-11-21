//
//  JSONCompatible.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

protocol JSONCompatible {
    init?(json: [String: Any]?)
    init()
    init?(data: Data?)
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any]
}
