//
//  ViewController.swift
//  GitHubFetcher
//
//  Created by Łukasz Sokołowski on 04/03/2020.
//  Copyright © 2020 Łukasz Sokołowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let connection = ConnectionManager()
    var repos = [Repository]()

    @IBOutlet weak var reposListTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        reposListTextView.text = ""
    }
    
    @IBAction func requestWithParamsButtonClicked(_ sender: Any) {
        let some = connection.requestWithParams(completion: {
            some in self.repos = some
            var str = ""
            if self.repos.count != 0 {
                for item in self.repos {
                    str = str + item.name + "\n"
                }
            }
            self.reposListTextView.text = str
            self.reposListTextView.reloadInputViews()
            print(self.repos.count)
        })
        print(some)

    }
    @IBAction func connectButton(_ sender: Any) {
        let url = "https://www.httpbin.org/get"
        connection.cacheTextFrom(url: url)
    }
    @IBAction func headersButtonClicked(_ sender: Any) {
        connection.httpHeaders()
    }
    @IBAction func withCredential(_ sender: Any) {
        print("CREDENTIAL")
        connection.authorizationWithCredential()
        print("---------------------------")
    }
    @IBAction func withoutCredential(_ sender: Any) {
        print("BASIC AUTH")
        connection.authorizationWithoutCredential()
        print("---------------------------")
    }
    @IBAction func showReposButtonClicked(_ sender: Any) {

    }

}

