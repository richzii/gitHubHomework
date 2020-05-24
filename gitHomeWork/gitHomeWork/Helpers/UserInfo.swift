//
//  UserInfo.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 24/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import Foundation

struct UserInfo {
    
    var globalUserName = ""
    
    mutating func getUsername(username: String) {
        self.globalUserName = username
    }
    
}
