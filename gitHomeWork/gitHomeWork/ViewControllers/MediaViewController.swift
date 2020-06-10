//
//  MediaViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 23/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            // print(directoryContents)

            // Get MP4 files:
            let mp4Files = directoryContents.filter{ $0.pathExtension == "mp4" }
            print("MP4 urls:",mp4Files)
            let mp4FileTitles = mp4Files.map{ $0.deletingPathExtension().lastPathComponent }
            print("MP4 list:", mp4FileTitles)
            
            // Get MP3 files:
            let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
            print("mp3 urls:",mp3Files)
            let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
            print("mp3 list:", mp3FileNames)

        } catch {
            print(error)
        }

    }
}
