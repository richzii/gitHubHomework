//
//  PhotosViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 23/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var jpgFileTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            // Get jpg files
            let jpgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
            jpgFileTitles = jpgFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("JPG list:", jpgFileTitles)

        } catch {
            print(error)
        }

    }
}
extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS: \(jpgFileTitles.count)")
        return jpgFileTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photCell") as! PhotoCell
        cell.fileTitle.text = jpgFileTitles[indexPath.row]
        
        return cell
    }
}
