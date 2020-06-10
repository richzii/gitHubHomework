//
//  PhotosViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 23/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            // print(directoryContents)

            // Filter the directory contents:
            let jpgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
            print("JPG urls:",jpgFiles)
            let jpgFileTitles = jpgFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("JPG list:", jpgFileTitles)

        } catch {
            print(error)
        }

    }
}
