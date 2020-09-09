//
//  CompanyInfo.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 29/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct CompanyInfo: Codable {
    let id: String
    let name: String
    let type: String
    let web: String
    let place: String
    let color: String
}
