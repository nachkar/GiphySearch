//
//  FavoritesViewControllerDataSource.swift
//  GiphySearch
//
//  Created by Noel Achkar on 23/11/2020.
//

import UIKit

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath as IndexPath) as! FavoritesCollectionViewCell
        cell.delegate = self
        cell.favoritesCollectionViewCellViewModel = viewModel.items[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
}
