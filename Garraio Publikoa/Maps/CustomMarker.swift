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
    var companyId: String
    var companyName: String
    var stopId: String
    var color: UIColor
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, companyId: String, companyName: String, stopId: String, color: UIColor) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.companyId = companyId
        self.companyName = companyName
        self.stopId = stopId
        self.color = color
    }
}
