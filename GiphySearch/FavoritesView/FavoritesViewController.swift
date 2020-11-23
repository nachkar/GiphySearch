//
//  FavoritesViewController.swift
//  GiphySearch
//
//  Created by Noel Achkar on 23/11/2020.
//

import UIKit

class FavoritesViewController: BaseViewController {

    let viewModel = FavoritesViewModel()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewModel()
    }

    func setupViewModel() {

        viewModel.didFinishLoading = { [weak self] items in
            self?.collectionView.reloadData()
        }

        viewModel.showAlertClosure = { [weak self] in
            print(self?.viewModel.error ?? "")
        }

        viewModel.initialise()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath as IndexPath) as! FavoritesCollectionViewCell
        cell.favoritesCollectionViewCellViewModel = viewModel.items[indexPath.row]
        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/2)-25, height: (self.view.frame.size.width/2)-25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension FavoritesViewController: FavoritesDelegate {
    func removeFavorite(imageId: String) {
        viewModel.removeFavorite(imageId: imageId)
    }
}
