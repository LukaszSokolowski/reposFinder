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
    var numOfResults = 30
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()

    }

    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
    }

    func dumbSearch(with keyword: String?) {
        guard let searchText = keyword else { return }
        let params: Parameters = ["q" : searchText]
        AF.request("https://api.github.com/search/repositories",parameters: params, encoding: URLEncoding.queryString)
          .validate()
          .responseDecodable(of: Repositories.self) {
            response in
            let header = response.response?.headers.value(for: "Link")
            let headers = header?.components(separatedBy: ",")
            var dictionary: [String: String] = [:]
            headers!.forEach({
                let components = $0.components(separatedBy:"; ")
                let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
                dictionary[components[1]] = cleanPath
            })
            print(dictionary)
            print("Next page path: \(dictionary["rel=\"next\""])")
                    guard let data = response.value else { print("Error") ; return }
                    print(data.totalCount)
                    self.repositories = data
                    self.tableView.reloadData()
        }
    }

    func getRepos(with keyword: String?)  {
        guard let keyword = keyword else { return }
        let params: Parameters = ["q" : keyword]
        let headers: HTTPHeaders = ["accept" : "application/vnd.github.mercy-preview+json"]
        AF.request("https://api.github.com/search/repositories", parameters: params, headers: headers)
          .validate()
          .responseDecodable(of: Repositories.self) { (response) in
            guard let repos = response.value else { return }
                self.repositories = repos
                print(repos.totalCount)
                self.tableView.reloadData()
                self.numOfResults = repos.totalCount
        }
    }
}
// MARK: - Search bar delegate methods
extension SearchReposTableViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dumbSearch(with: searchBar.text)
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        //getRepos(with: searchBar.text)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //getRepos(with: searchText)
        dumbSearch(with: searchText)
        print(searchText)
    }
}

// MARK: - Table view data source
extension SearchReposTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfResults
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if repositories.repos.count != 0 {
            print(indexPath.row)
            if indexPath.row > repositories.repos.count {

            }
            cell.textLabel?.text = repositories.repos[indexPath.row].name
            cell.detailTextLabel?.text = repositories.repos[indexPath.row].description
        } else {
            cell.textLabel?.text = "----"
            cell.detailTextLabel?.text = "---- ---- ----"
        }
        return cell
    }
}

