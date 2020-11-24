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

extension FavoritesViewController: FavoritesDelegate {
    func removeFavorite(imageId: String) {
        viewModel.removeFavorite(imageId: imageId)

        //Reload Favorites in SearchView
        if let navigation = self.tabBarController?.viewControllers![0] as? UINavigationController {
            if let controller = navigation.viewControllers[0] as? ImagesViewController {
                controller.reloadDataFav(imageId: imageId)
            }
        }
    }
}
