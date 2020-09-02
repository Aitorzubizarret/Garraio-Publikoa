//
//  MarkerListViewModel.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 25/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class MarkerListViewModel {
    
    // Binding
    var binding = { () -> () in }
    
    // Data Source
    var companyList: [Company] = [] {
        didSet {
            self.binding()
        }
    }
    
    ///
    /// Gets data from Local JSON files.
    ///
    public func getCompany(filename: FileName) {
        LocalFile().readJSONFile(fileName: filename) { (success, data) in
            DispatchQueue.main.async {
                if success, let receivedData = data {
                    self.companyList.append(receivedData)
                }
            }
        }
    }
    
}
