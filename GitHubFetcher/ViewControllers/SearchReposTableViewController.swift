//
//  SearchReposTableViewController.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 18/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import UIKit
//dont use alamofire here try to aviod show that you use this

class SearchReposTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let connection = ConnectionManager()
        connection.getRepos()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
