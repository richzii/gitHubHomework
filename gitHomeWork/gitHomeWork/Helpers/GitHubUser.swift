//
//  GithubUser.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 24/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import Foundation

// MARK: - GitHubUser
struct GitHubUser: Codable {
    let avatarURL: String?
    let name, company, bio: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name, company, bio
    }
}
