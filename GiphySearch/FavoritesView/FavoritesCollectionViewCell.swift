//
//  FavoritesCollectionViewCell.swift
//  GiphySearch
//
//  Created by Noel Achkar on 23/11/2020.
//

import UIKit

protocol FavoritesDelegate {
    func removeFavorite(imageId: String)
}

class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!

    var delegate: FavoritesDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func removeFavorite() {
        guard let delegate = self.delegate else {
            return
        }

        delegate.removeFavorite(imageId: favoritesCollectionViewCellViewModel!.imageId)
    }

    var favoritesCollectionViewCellViewModel: FavoritesCellViewModelItem? {
         didSet {
            imageView.sd_setImage(with: URL.init(string: favoritesCollectionViewCellViewModel?.imageUrl ?? ""), completed: {_, _, _, _ in })
            titleLbl.text = favoritesCollectionViewCellViewModel?.imageTitle ?? ""
            detailLbl.text = favoritesCollectionViewCellViewModel?.imageSource ?? ""
        }
    }
}
