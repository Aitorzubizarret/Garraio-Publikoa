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
    var markerList: [Marker] = [] {
        didSet {
            self.binding()
        }
    }
    
    // Get data from Local JSON files.
    func getLocalDataMarkers() {
        LocalFile().readBusJSON(fileName: FileName.bilbobus) { (success, data) in
            DispatchQueue.main.async {
                if success, let receivedBusData = data {
                    for busStop in receivedBusData.stops {
                        if let doubleLat = Double(busStop.lat), let doubleLng = Double(busStop.lng) {
                            let marker: Marker = Marker(id: busStop.id, name: busStop.name, lat: doubleLat, lng: doubleLng)
                            self.markerList.append(marker)
                        }
                    }
                }
            }
        }
    }
    
}
