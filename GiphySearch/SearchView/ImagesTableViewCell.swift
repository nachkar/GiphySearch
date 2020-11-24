//
//  ImagesTableViewCell.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit
import FLAnimatedImage
import SDWebImageFLPlugin

protocol ImagesCellDelegate {
    func updateImageState(image: ImagesCellViewModelItem)
}

class ImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageAnimated: FLAnimatedImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!

    var delegate: ImagesCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func updateImageState() {
        guard let delegate = self.delegate else {
            return
        }

        delegate.updateImageState(image: imageCellViewModel!)

        let isFavorite = imageCellViewModel!.isFavorite
        imageCellViewModel?.isFavorite = isFavorite ? false : true

        let image = isFavorite ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
        favBtn.setImage(image, for: .normal)
    }

    var imageCellViewModel: ImagesCellViewModelItem? {
         didSet {
            imageAnimated.sd_setImage(with: URL.init(string: imageCellViewModel?.imageUrl ?? ""), completed: {_, _, _, _ in })
            titleLbl.text = imageCellViewModel?.imageTitle ?? ""
            detailLbl.text = imageCellViewModel?.imageSource ?? ""

            let image = imageCellViewModel!.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            favBtn.setImage(image, for: .normal)
         }
    }
}
