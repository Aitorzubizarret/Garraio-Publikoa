//
//  Stop.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 29/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct Stop: Codable {
    let id: String
    let name: String
    let lat: String
    let lng: String
    let linesId: [String]
}
