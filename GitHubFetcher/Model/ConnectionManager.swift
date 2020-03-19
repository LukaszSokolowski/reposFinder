//
//  ConnectionManager.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 18/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import Foundation
import Alamofire

class ConnectionManager {
    var repositories = Repositories()
    func getRepos()  {
        let params: Parameters = ["q" : "swift"]
        let headers: HTTPHeaders = ["accept" : "application/vnd.github.mercy-preview+json"]
        AF.request("https://api.github.com/search/repositories", parameters: params, headers: headers).responseDecodable(of: Repositories.self) { (response) in
            guard let repos = response.value else { print("???") ; return }
            self.repositories = repos
            print("Repo name: \(self.repositories.repos[0].name)")
            print("Search results number: \(self.repositories.totalCount)")
            print("Owner name: \(self.repositories.repos[0].user.name)")
            print("Total forks: \(self.repositories.repos[0].forks)")
            print("Total stars: \(self.repositories.repos[0].stars)")
            print("Total watchers: \(self.repositories.repos[0].watchers)")
            print("Description: \(self.repositories.repos[0].description)")
        }
    }
}

