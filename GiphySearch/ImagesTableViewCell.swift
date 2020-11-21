//
//  ImagesTableViewCell.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit
import FLAnimatedImage
import SDWebImageFLPlugin

class ImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageAnimated: FLAnimatedImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageAnimated.sd_setImage(with: URL.init(string: "https://media.giphy.com/media/WTXdofYvFFhMTYhVKp/giphy.gif"), completed: {_, _, _, _ in })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
