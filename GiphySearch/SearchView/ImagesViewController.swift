//
//  ImagesViewController.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

class ImagesViewController: BaseViewController {

    let viewModel = ImagesViewModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSearchBar()
        setupViewModel()
        setupTableView()
    }

    func setupTableView() {
        self.tableView.tableFooterView = UIView()
    }

    func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
//        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search giphy..."
//        search.searchBar.delegate = self
        search.searchBar.isTranslucent = false
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        search.searchBar.barTintColor = .white
        search.searchBar.barStyle = .default

        if #available(iOS 13.0, *) {
            search.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }

        definesPresentationContext = true
    }

    func setupViewModel() {
        viewModel.didFinishLoading = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.showAlertClosure = { [weak self] in
            print(self?.viewModel.error ?? "")
        }

        viewModel.updateLoadingStatus = { [weak self] isLoading in
            self?.activityIndicator.isHidden = !isLoading
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
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
