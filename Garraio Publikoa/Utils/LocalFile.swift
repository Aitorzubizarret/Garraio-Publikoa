//
//  LocalFile.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 21/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

enum FileName: String {
    case bilbobus = "Bilbobus"
}

class LocalFile {
    
    ///
    /// Reads a local file and sends back its data.
    /// - Parameter fileName: The name of the file.
    /// - Parameter success: 'True' if the JSON file has been read and / or decode correctly, otherwise 'false'.
    /// - Parameter data: The data of the file as Bus.
    ///
    public func readBusJSON(fileName: FileName, completion: @escaping(_ success: Bool, _ data: Bus?) -> Void) {
        if let path = Bundle.main.path(forResource: fileName.rawValue, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                
                // Get the data from the JSON file.
                let data = try Data(contentsOf: fileUrl, options: Data.ReadingOptions.alwaysMapped)
                
                // Decode the data from JSON to Bus object.
                let busInfo = try JSONDecoder().decode(Bus.self, from: data)
                
                completion(true, busInfo)
            } catch let error {
                completion(false, nil)
                print("Error: \(error)")
            }
        } else {
            print("Error getting the path of the file.")
            completion(false, nil)
        }
    }
}
