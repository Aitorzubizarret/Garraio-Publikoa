//
//  StopsIdWithStopTime.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 01/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct StopsIdWithStopTime: Codable {
    let id: String
    let stopTime: [StopTime]
}
