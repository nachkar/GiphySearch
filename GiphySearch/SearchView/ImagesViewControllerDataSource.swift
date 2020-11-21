//
//  ImagesViewControllerDataSource.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

extension ImagesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesCell", for: indexPath) as! ImagesTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .white

        cell.imageCellViewModel = viewModel.items[indexPath.row]

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount 
    }
}
