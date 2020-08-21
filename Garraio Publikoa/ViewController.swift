//
//  ViewController.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 20/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    var mapsFromApple: MapsFromApple?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMapsFromApple()
        
        LocalFile().readBusJSON(fileName: "Bilbobus") { (success, data) in
            DispatchQueue.main.async {
                if success, let receivedBusData = data {
                    for busStop in receivedBusData.stops {
                        if let doubleLat = Double(busStop.lat), let doubleLng = Double(busStop.lng) {
                            self.mapsFromApple?.addMarker(title: busStop.name, lat: doubleLat, lng: doubleLng)
                        }
                    }
                }
            }
        }
    }
    
    ///
    /// Creates the MapsFromApple object and adds the received mapView to the main view.
    ///
    private func addMapsFromApple() {
        self.mapsFromApple = MapsFromApple() // Creates the object.
        
        guard let maps = self.mapsFromApple else { return }
        
        self.view.addSubview(maps.getMapView(size: self.view.bounds)) // Adds the view (with the maps enbedded) into our main view.
    }

}

