//
//  HomeViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 20/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class CellClass: UIViewController {
    
}

class HomeViewController: UIViewController {

    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var gitUsername = "ioslekcijas"
    var repoCount = 0
    var allRepos = [GitHubRepository]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLBL: UILabel!
    @IBOutlet weak var companyLBL: UILabel!
    @IBOutlet weak var bioLBL: UILabel!
    @IBOutlet weak var searchInputField: UITextField!
    @IBOutlet weak var selectRepositoryBtn: UIButton!
    @IBOutlet weak var downloadRepositoryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        displayGitUserData()
        displayRepositories()
    }
    
    func displayGitUserData() {
        let url = URL(string: "https://api.github.com/users/\(gitUsername)")
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
    
    func displayRepositories() {
        let url = URL(string: "https://api.github.com/users/\(gitUsername)/repos")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if let data = data {
                    let decoder = JSONDecoder()
                    if let repositories = try? decoder.decode([GitHubRepository].self, from: data) {
                        DispatchQueue.main.async {
                            self.allRepos = repositories
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
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                        self.transparentView.alpha = 0.5
                        self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 200)
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                        self.transparentView.alpha = 0.0
                        self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func selectRepository(_ sender: UIButton) {
        selectedButton = sender
        addTransparentView(frames: sender.frame)
    }
    
    @IBAction func searchUser(_ sender: UIButton) {
        gitUsername = self.searchInputField.text!
        displayGitUserData()
        displayRepositories()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = allRepos[indexPath.row].name
        return cell
    }
}
