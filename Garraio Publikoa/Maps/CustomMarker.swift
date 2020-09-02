//
//  CustomMarker.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 01/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import UIKit
import MapKit

class CustomMarker: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var companyId: String?
    var stopId: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, companyId: String, stopId: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.companyId = companyId
        self.stopId = stopId
    }
}
