//
//  Line.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 26/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct Line: Codable {
    let id: String
    let name: String
    let color: String
    let web: String
    let updatedOn: String
    let directions: [Direction]
}
