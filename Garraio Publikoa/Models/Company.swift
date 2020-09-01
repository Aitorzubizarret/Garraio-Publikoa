//
//  Company.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 27/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct Company: Codable {
    let info: CompanyInfo
    let stops: [Stop]
    let lines: [Line]
}
