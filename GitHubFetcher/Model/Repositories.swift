//
//  Repositories.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 18/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import Foundation
class Repositories: Decodable {
    var repos: [Repository] = []
    var totalCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case repos = "items"
        case totalCount = "total_count"
    }
}
