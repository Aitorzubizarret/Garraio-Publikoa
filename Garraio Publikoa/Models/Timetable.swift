//
//  Timetable.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 01/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct Timetable: Codable {
    let id: String
    let name: String
    let startTime: String
    let endTime: String
    let journeyDurationMin: String
}
