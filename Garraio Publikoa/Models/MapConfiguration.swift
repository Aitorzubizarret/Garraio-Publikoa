//
//  MapConfiguration.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 20/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct MapConfiguration {
    let placeName: String
    let centerPointLat: Double
    let centerPointLng: Double
    let latitudinalMeters: Double
    let longitudinalMeters: Double
    
    init() {
        placeName = "Bilbo"
        centerPointLat = 43.262985
        centerPointLng = -2.935013
        latitudinalMeters = 4000
        longitudinalMeters = 4000
    }
}
