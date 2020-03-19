//
//  SearchReposTableViewController.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 18/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import UIKit
import Alamofire

class SearchReposTableViewController: UITableViewController, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    let connection = ConnectionManager()
    var repositories = Repositories()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        getRepos()
    }

    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
    }

    func getRepos()  {
        let params: Parameters = ["q" : "swift"]
        let headers: HTTPHeaders = ["accept" : "application/vnd.github.mercy-preview+json"]
        AF.request("https://api.github.com/search/repositories", parameters: params, headers: headers).responseDecodable(of: Repositories.self) { (response) in
            guard let repos = response.value else { return }
            self.repositories = repos
            self.tableView.reloadData()
//            print("Repo name: \(self.repositories.repos[0].name)")
//            print("Search results number: \(self.repositories.totalCount)")
//            print("Owner name: \(self.repositories.repos[0].user.name)")
//            print("Total forks: \(self.repositories.repos[0].forks)")
//            print("Total stars: \(self.repositories.repos[0].stars)")
//            print("Total watchers: \(self.repositories.repos[0].watchers)")
//            print("Description: \(self.repositories.repos[0].description)")
        }
    }

}
// MARK: - Search bar delegate methods
extension SearchReposTableViewController {
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          print("Start search!")
      }

      func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
          searchBar.showsCancelButton = true
      }

      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          resignFirstResponder()
          searchBar.endEditing(true)
          searchBar.showsCancelButton = false
          print("cancel searching")
      }

      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          print(searchText)
      }
}

// MARK: - Table view data source
extension SearchReposTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if repositories.repos.count != 0 {
            cell.textLabel?.text = repositories.repos[indexPath.row].name
            cell.detailTextLabel?.text = repositories.repos[indexPath.row].description
        } else {
            cell.textLabel?.text = "----"
            cell.detailTextLabel?.text = "---- ---- ----"
        }
        return cell
    }
}

