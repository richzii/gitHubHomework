//
//  DocumentsViewController.swift
//  gitHomeWork
//
//  Created by Rihards Zīverts on 23/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            // print(directoryContents)

            // PDF files:
            let pdfFiles = directoryContents.filter{ $0.pathExtension == "pdf" }
            print("PDF urls:", pdfFiles)
            let pdfFileTitles = pdfFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("PDF list:", pdfFileTitles)
            
            // XLS files
            let xlsFiles = directoryContents.filter{ $0.pathExtension == "xls" }
            print("XLS urls:", xlsFiles)
            let xlsFileTitles = xlsFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("XLS list:", xlsFileTitles)
            
            // PPTX files
            let pptxFiles = directoryContents.filter{ $0.pathExtension == "pptx" }
            print("PPTX urls:", pptxFiles)
            let pptxFileTitles = pptxFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("PPTX list:", pptxFileTitles)
            
            // DOCX files
            let docxFiles = directoryContents.filter{ $0.pathExtension == "docx" }
            print("DOCX urls:", docxFiles)
            let docxFileTitles = docxFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("DOCX list:", docxFileTitles)

        } catch {
            print(error)
        }

    }
}
