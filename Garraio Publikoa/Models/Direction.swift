//
//  Direction.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 27/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct Direction: Codable {
    let id: String
    let name: String
    let from: String
    let to: String
    let polyline: String
    let timetable: [Timetable]
    let stopsIdWithStopTime: [StopsIdWithStopTime]
}
