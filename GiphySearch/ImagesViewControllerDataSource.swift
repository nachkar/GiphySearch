//
//  ImagesViewControllerDataSource.swift
//  GiphySearch
//
//  Created by Noel Achkar on 21/11/2020.
//

import UIKit

extension ImagesViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesCell", for: indexPath) as! ImagesTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .white

//        cell.addressTableViewCellViewModel = viewModel.items[indexPath.row]

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
