//
//  main.swift
//  pdfburst
//
//  Created by Nick Hone on 2022-04-07.
//

import Foundation
import PDFKit

do {
    let myFileManager = FileManager()
    let myURL = URL(fileURLWithPath: myFileManager.currentDirectoryPath, isDirectory: true)
    
    let myDirConts = try myFileManager.contentsOfDirectory(at: myURL, includingPropertiesForKeys: [])
    
    for fileUrl in myDirConts {
        if(fileUrl.pathExtension == "pdf") {
            let myPDFDoc = PDFDocument(url: fileUrl)
            
            for myPageCount in 0...(myPDFDoc!.pageCount-1) {
                var newFileName = fileUrl.lastPathComponent
                newFileName.insert(contentsOf: " " + String(myPageCount), at: newFileName.firstIndex(of: ".")!)
                
                var newURL = fileUrl.deletingLastPathComponent()
                newURL.appendPathComponent(newFileName)
                
                let newPDFPage = myPDFDoc!.page(at: myPageCount)
                let newPDF = PDFDocument()
                newPDF.insert(newPDFPage!, at: 0)
                newPDF.write(to: newURL)
            }
        }
    }
} catch {
    print(error)
}



// Iteration over command line arguments
// for arg in CommandLine.arguments {
// }
