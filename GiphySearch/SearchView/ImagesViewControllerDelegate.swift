//
//  ImagesViewControllerDelegate.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

extension ImagesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.itemCount {
            //Load More
            self.loadMoreIndicator.startAnimating()

            let status: ImagesStatus = (self.navigationItem.searchController?.searchBar.isFirstResponder)! ? .searching : .trending
            self.viewModel.loadMoreData(status: status)
        }
    }
}
