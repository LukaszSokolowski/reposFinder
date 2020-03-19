//
//  Repository.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 18/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import Foundation

final class Repository: Decodable {
    var name: String
    var user: User
    var forks: Int
    var stars: Int
    var watchers: Int
    //var languages: [String]
    init(name: String, user: User, forks: Int, stars: Int, watchers: Int) {
        self.name = name
        self.user = user
        self.forks = forks
        self.stars = stars
        self.watchers = watchers
      //  self.languages = languages
    }

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case user = "owner"
        case forks = "forks_count"
        case stars = "stargazers_count"
        case watchers = "watchers_count"
//        case languages = ????
    }
}
