//
//  ImagesViewController.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

class ImagesViewController: BaseViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    let viewModel = ImagesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSearchBar()
        setupViewModel()
    }

    func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search giphy..."
        search.searchBar.delegate = self
        search.searchBar.isTranslucent = false
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false

        if #available(iOS 13.0, *) {
            search.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }

        definesPresentationContext = true
    }

    func setupViewModel() {
        viewModel.didFinishLoading = { [weak self] in
            self?.loadMoreIndicator.stopAnimating()
            self?.tableView.reloadData()
        }

        viewModel.showAlertClosure = { [weak self] in
            print(self?.viewModel.error ?? "")
        }

        viewModel.updateLoadingStatus = { [weak self] isLoading in
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }

        viewModel.initialise()
    }

    func reloadDataFav(imageId: String) {
        viewModel.reloadFavData(imageId: imageId)
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

extension ImagesViewController: ImagesCellDelegate {
    func updateImageState(image: ImagesCellViewModelItem) {
        viewModel.updateImageState(image: image)
    }
}

extension ImagesViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {

        NSObject.cancelPreviousPerformRequests(withTarget: self)

        let text = searchController.searchBar.text ?? ""
        if text.isStringNull() {
            viewModel.cancelFilter()
            return
        }

        perform(#selector(searchText(text:)), with: searchController.searchBar.text!, afterDelay: 0.4)
    }

    @objc func searchText(text: String) {
        self.viewModel.filterData(text: text, isLoadMore: false)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        //        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true

        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
