//
//  DataItem.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct DataItem: JSONCompatible {
    var source: String
    var trending_datetime: String
    var analytics: Analytics
    var is_sticker: Int
    var source_post_url: String
    var rating: String
    var type: String
    var content_url: String
    var import_datetime: String
    var embed_url: String
    var username: String
    var bitly_gif_url: String
    var slug: String
    var source_tld: String
    var id: String
    var bitly_url: String
    var analytics_response_payload: String
    var title: String
    var images: Images
    var url: String

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        source = json["source"] as? String ?? ""
        trending_datetime = json["trending_datetime"] as? String ?? ""
        analytics = Analytics(json: json["analytics"] as? [String: Any]) ?? Analytics()
        is_sticker = json["is_sticker"] as? Int ?? 0
        source_post_url = json["source_post_url"] as? String ?? ""
        rating = json["rating"] as? String ?? ""
        type = json["type"] as? String ?? ""
        content_url = json["content_url"] as? String ?? ""
        import_datetime = json["import_datetime"] as? String ?? ""
        embed_url = json["embed_url"] as? String ?? ""
        username = json["username"] as? String ?? ""
        bitly_gif_url = json["bitly_gif_url"] as? String ?? ""
        slug = json["slug"] as? String ?? ""
        source_tld = json["source_tld"] as? String ?? ""
        id = json["id"] as? String ?? ""
        bitly_url = json["bitly_url"] as? String ?? ""
        analytics_response_payload = json["analytics_response_payload"] as? String ?? ""
        title = json["title"] as? String ?? ""
        images = Images(json: json["images"] as? [String: Any]) ?? Images()
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

    init(source: String, trending_datetime: String, analytics: Analytics, is_sticker: Int, source_post_url: String, rating: String, type: String, content_url: String, import_datetime: String, embed_url: String, username: String, bitly_gif_url: String, slug: String, source_tld: String, id: String, bitly_url: String, analytics_response_payload: String, title: String, images: Images, url: String) {
        self.source = source
        self.trending_datetime = trending_datetime
        self.analytics = analytics
        self.is_sticker = is_sticker
        self.source_post_url = source_post_url
        self.rating = rating
        self.type = type
        self.content_url = content_url
        self.import_datetime = import_datetime
        self.embed_url = embed_url
        self.username = username
        self.bitly_gif_url = bitly_gif_url
        self.slug = slug
        self.source_tld = source_tld
        self.id = id
        self.bitly_url = bitly_url
        self.analytics_response_payload = analytics_response_payload
        self.title = title
        self.images = images
        self.url = url
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["source"] = source
        dict["trending_datetime"] = trending_datetime
        dict["analytics"] = analytics.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["is_sticker"] = is_sticker
        dict["source_post_url"] = source_post_url
        dict["rating"] = rating
        dict["type"] = type
        dict["content_url"] = content_url
        dict["import_datetime"] = import_datetime
        dict["embed_url"] = embed_url
        dict["username"] = username
        dict["bitly_gif_url"] = bitly_gif_url
        dict["slug"] = slug
        dict["source_tld"] = source_tld
        dict["id"] = id
        dict["bitly_url"] = bitly_url
        dict["analytics_response_payload"] = analytics_response_payload
        dict["title"] = title
        dict["images"] = images.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["url"] = url
        return dict
    }

}
