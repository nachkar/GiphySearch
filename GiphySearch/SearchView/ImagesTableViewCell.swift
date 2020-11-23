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
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var imageCellViewModel: ImagesCellViewModelItem? {
         didSet {
            imageAnimated.sd_setImage(with: URL.init(string: imageCellViewModel?.imageUrl ?? ""), completed: {_, _, _, _ in })
            titleLbl.text = imageCellViewModel?.imageTitle ?? ""
            detailLbl.text = imageCellViewModel?.imageSource ?? ""
         }
    }
}
