//
//  ConnectionManager.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 04/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import Foundation
import Alamofire

class Repository: Codable
{
    var id: Int
    var name: String
    var isPrivate: Bool

    init(id: Int, name: String, isPrivate: Bool) {
        self.id = id
        self.name = name
        self.isPrivate = isPrivate
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isPrivate = "private"
    }


}

final class ConnectionManager {
    func cacheTextFrom(url: String) {
        AF.request(url).response { response in
            debugPrint(response)
        }
    }

    func requestWithParams(completion: @escaping ([Repository])->()) -> String{
        var repos = [Repository]()
        let headers: HTTPHeaders = [.accept("application/vnd.github.v3+json")]

        AF.request("https://api.github.com/users/LukaszSokolowski/repos",method: .get, headers: headers).response { response in
            do {
                let decoder = JSONDecoder()
                repos = try decoder.decode(Array<Repository>.self, from:
                    response.data!)

                for item in repos {
                    print(item.name)
                }
                completion(repos)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        return "xDDD"
    }

    func httpHeaders() {
        let headers: HTTPHeaders = [
                   .authorization(username: "test@email.com", password: "xD"),
                   .accept("application/json"),
                   .contentDisposition("contentDisposition"),
                   .defaultAcceptEncoding,
                   .userAgent("userAgent")

               ]

               AF.request("https://httpbin.org/headers", headers: headers).responseJSON { response in
                   debugPrint(response)
               }
    }

    func authorizationWithoutCredential() {
        // Normal way to authenticate using the .authenticate with username and password
        let user = "test@email.com"
        let password = "testpassword"
    AF.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(username: user, password: password)
            .responseJSON { response in
                debugPrint(response)
        }
    }

    func authorizationWithCredential() {
        // Authentication using URLCredential
        let user = "test@email.com"
        let password = "testpassword"

        let credential = URLCredential(user: user, password: password, persistence: .forSession)

        AF.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(with: credential)
            .responseJSON { response in
                debugPrint(response)
        }
    }
}
