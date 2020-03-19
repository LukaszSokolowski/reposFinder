//
//  User.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 19/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import Foundation

class User: Decodable {
    var name: String
    var id: Int

    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case id = "id"
    }
}
