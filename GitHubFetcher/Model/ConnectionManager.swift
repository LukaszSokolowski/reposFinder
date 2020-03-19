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
            print("xD \(self.repositories.repos[0].name)") // repo name
            print("xD \(self.repositories.totalCount)") // total search results
            print("xD \(self.repositories.repos[0].user.name)") //owner name
            print("xD \(self.repositories.repos[0].forks)") // total forks
            print("xD \(self.repositories.repos[0].stars)") // total stars
            print("xD \(self.repositories.repos[0].watchers)") // total watchers


            print(repos)
        }
        print("Hehe")
    }
}

