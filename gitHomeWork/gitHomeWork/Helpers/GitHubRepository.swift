//
//  GitHubRepository.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 24/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import Foundation

// MARK: - GitHubRepository
struct GitHubRepository: Codable {
    let name: String!

    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct RepoDownloadURL: Codable {
    let downloadURL: String!

    enum CodingKeys: String, CodingKey {
        case downloadURL = "download_url"
    }
}
