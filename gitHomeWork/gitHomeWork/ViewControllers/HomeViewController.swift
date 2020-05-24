//
//  HomeViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 20/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var gitUsername = "ioslekcijas"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLBL: UILabel!
    @IBOutlet weak var companyLBL: UILabel!
    @IBOutlet weak var bioLBL: UILabel!
    @IBOutlet weak var searchInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayGitUserData()
    }
    
    func displayGitUserData() {
        let url = URL(string: getGitHubUserUrl(username: gitUsername))
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let gitHubUser = try? decoder.decode(GitHubUser.self, from: data) {
                    DispatchQueue.main.async {
                        self.updateUserInterface(with: gitHubUser)
                    }
                } else {
                    print(error?.localizedDescription ?? "")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func updateUserInterface(with user: GitHubUser) {
        self.userNameLBL.text = user.name
        self.companyLBL.text = user.company
        self.bioLBL.text = user.bio
        imageView.downloaded(from: user.avatarURL ?? "https://dummyimage.com/300x300/000/ffffff&text=No+avatar+available")
    }
    
    @IBAction func searchUser(_ sender: UIButton) {
        gitUsername = self.searchInputField.text!
        displayGitUserData()
    }
}
