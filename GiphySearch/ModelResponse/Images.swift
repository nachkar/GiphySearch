//
//  Images.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import Foundation

struct Images: JSONCompatible {
    var fixed_height_small: Fixed_height_small
    var downsized_medium: Downsized_medium
    var fixed_width: Fixed_width
    var preview_webp: Preview_webp
    var fixed_height_small_still: Fixed_height_small_still
    var preview_gif: Preview_gif
    var downsized: Downsized
    var fixed_height: Fixed_height
    var w480_still: W480_still
    var fixed_width_downsampled: Fixed_width_downsampled
    var original: Original
    var original_mp4: Original_mp4
    var original_still: Original_still
    var preview: Preview
    var fixed_width_small: Fixed_width_small
    var fixed_height_downsampled: Fixed_height_downsampled
    var downsized_large: Downsized_large
    var fixed_width_still: Fixed_width_still
    var looping: Looping
    var fixed_height_still: Fixed_height_still
    var fixed_width_small_still: Fixed_width_small_still
    var downsized_small: Downsized_small
    var downsized_still: Downsized_still

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        fixed_height_small = Fixed_height_small(json: json["fixed_height_small"] as? [String: Any]) ?? Fixed_height_small()
        downsized_medium = Downsized_medium(json: json["downsized_medium"] as? [String: Any]) ?? Downsized_medium()
        fixed_width = Fixed_width(json: json["fixed_width"] as? [String: Any]) ?? Fixed_width()
        preview_webp = Preview_webp(json: json["preview_webp"] as? [String: Any]) ?? Preview_webp()
        fixed_height_small_still = Fixed_height_small_still(json: json["fixed_height_small_still"] as? [String: Any]) ?? Fixed_height_small_still()
        preview_gif = Preview_gif(json: json["preview_gif"] as? [String: Any]) ?? Preview_gif()
        downsized = Downsized(json: json["downsized"] as? [String: Any]) ?? Downsized()
        fixed_height = Fixed_height(json: json["fixed_height"] as? [String: Any]) ?? Fixed_height()
        w480_still = W480_still(json: json["480w_still"] as? [String: Any]) ?? W480_still()
        fixed_width_downsampled = Fixed_width_downsampled(json: json["fixed_width_downsampled"] as? [String: Any]) ?? Fixed_width_downsampled()
        original = Original(json: json["original"] as? [String: Any]) ?? Original()
        original_mp4 = Original_mp4(json: json["original_mp4"] as? [String: Any]) ?? Original_mp4()
        original_still = Original_still(json: json["original_still"] as? [String: Any]) ?? Original_still()
        preview = Preview(json: json["preview"] as? [String: Any]) ?? Preview()
        fixed_width_small = Fixed_width_small(json: json["fixed_width_small"] as? [String: Any]) ?? Fixed_width_small()
        fixed_height_downsampled = Fixed_height_downsampled(json: json["fixed_height_downsampled"] as? [String: Any]) ?? Fixed_height_downsampled()
        downsized_large = Downsized_large(json: json["downsized_large"] as? [String: Any]) ?? Downsized_large()
        fixed_width_still = Fixed_width_still(json: json["fixed_width_still"] as? [String: Any]) ?? Fixed_width_still()
        looping = Looping(json: json["looping"] as? [String: Any]) ?? Looping()
        fixed_height_still = Fixed_height_still(json: json["fixed_height_still"] as? [String: Any]) ?? Fixed_height_still()
        fixed_width_small_still = Fixed_width_small_still(json: json["fixed_width_small_still"] as? [String: Any]) ?? Fixed_width_small_still()
        downsized_small = Downsized_small(json: json["downsized_small"] as? [String: Any]) ?? Downsized_small()
        downsized_still = Downsized_still(json: json["downsized_still"] as? [String: Any]) ?? Downsized_still()
    }

    init() {
        self.init(json: [:])!
    }

    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }

    init(fixed_height_small: Fixed_height_small, downsized_medium: Downsized_medium, fixed_width: Fixed_width, preview_webp: Preview_webp, fixed_height_small_still: Fixed_height_small_still, preview_gif: Preview_gif, downsized: Downsized, fixed_height: Fixed_height, w480_still: W480_still, fixed_width_downsampled: Fixed_width_downsampled, original: Original, original_mp4: Original_mp4, original_still: Original_still, preview: Preview, fixed_width_small: Fixed_width_small, fixed_height_downsampled: Fixed_height_downsampled, downsized_large: Downsized_large, fixed_width_still: Fixed_width_still, looping: Looping, fixed_height_still: Fixed_height_still, fixed_width_small_still: Fixed_width_small_still, downsized_small: Downsized_small, downsized_still: Downsized_still) {
        self.fixed_height_small = fixed_height_small
        self.downsized_medium = downsized_medium
        self.fixed_width = fixed_width
        self.preview_webp = preview_webp
        self.fixed_height_small_still = fixed_height_small_still
        self.preview_gif = preview_gif
        self.downsized = downsized
        self.fixed_height = fixed_height
        self.w480_still = w480_still
        self.fixed_width_downsampled = fixed_width_downsampled
        self.original = original
        self.original_mp4 = original_mp4
        self.original_still = original_still
        self.preview = preview
        self.fixed_width_small = fixed_width_small
        self.fixed_height_downsampled = fixed_height_downsampled
        self.downsized_large = downsized_large
        self.fixed_width_still = fixed_width_still
        self.looping = looping
        self.fixed_height_still = fixed_height_still
        self.fixed_width_small_still = fixed_width_small_still
        self.downsized_small = downsized_small
        self.downsized_still = downsized_still
    }

    /// This function generate a json dictionary from the model.
    ///
    /// - Parameter useOriginalJsonKey: This parameter take effect only when you have modified a property's name making it different to the original json key. If true, the original json key will be used when generate json dictionary, otherwise, the modified property name will be used as key in the dictionary.
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["fixed_height_small"] = fixed_height_small.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["downsized_medium"] = downsized_medium.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_width"] = fixed_width.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["preview_webp"] = preview_webp.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_height_small_still"] = fixed_height_small_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["preview_gif"] = preview_gif.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["downsized"] = downsized.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_height"] = fixed_height.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["480w_still"] = w480_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_width_downsampled"] = fixed_width_downsampled.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["original"] = original.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["original_mp4"] = original_mp4.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["original_still"] = original_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["preview"] = preview.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_width_small"] = fixed_width_small.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_height_downsampled"] = fixed_height_downsampled.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["downsized_large"] = downsized_large.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_width_still"] = fixed_width_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["looping"] = looping.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_height_still"] = fixed_height_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["fixed_width_small_still"] = fixed_width_small_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["downsized_small"] = downsized_small.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["downsized_still"] = downsized_still.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        return dict
    }

}
