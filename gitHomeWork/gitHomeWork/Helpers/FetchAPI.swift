//
//  fetchAPI.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 24/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

extension UIViewController {
    func getGitHubUserUrl(username:String) -> String {
        let userUrl = "https://api.github.com/users/\(username)"
        return userUrl
    }
    func getRepoList(username:String) -> String {
        let repoListUrl = "https://api.github.com/users/\(username)/repos"
        return repoListUrl
    }
}
