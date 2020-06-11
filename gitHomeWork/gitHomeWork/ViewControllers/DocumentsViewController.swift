//
//  DocumentsViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 23/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var documentFileTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            // Get documents
            let documentFiles = directoryContents.filter{ $0.pathExtension == "pdf" || $0.pathExtension == "xls" || $0.pathExtension == "pptx" || $0.pathExtension == "docx"}
            documentFileTitles = documentFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("Document list:", documentFileTitles)

        } catch {
            print(error)
        }
    }
}
extension DocumentsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF ROWS: \(documentFileTitles.count)")
        return documentFileTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell") as! DocumentCell
        cell.titleLabel.text = documentFileTitles[indexPath.row]
        
        return cell
    }
}
