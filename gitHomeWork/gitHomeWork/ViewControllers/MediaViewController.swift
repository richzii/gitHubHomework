//
//  MediaViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 23/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var mediaFileTitles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            // Get media files:
            let mediaFiles = directoryContents.filter{ $0.pathExtension == "mp4" || $0.pathExtension == "mp3"}
            mediaFileTitles = mediaFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("Media file list:", mediaFileTitles)

        } catch {
            print(error)
        }

    }
}
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS: \(mediaFileTitles.count)")
        return mediaFileTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medCell") as! MediaCell
        cell.titleLabel.text = mediaFileTitles[indexPath.row]
        
        return cell
    }
}
