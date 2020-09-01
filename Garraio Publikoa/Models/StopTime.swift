//
//  StopTime.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 29/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct StopTime: Codable {
    let id: String
    let timetableId: String
    let aproxTime: [String]
}
