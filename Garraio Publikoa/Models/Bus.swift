//
//  Bus.swift
//  Garraio Publikoa
//
//  Created by Aitor Zubizarreta on 21/08/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

struct Bus: Codable {
    let info: BusInfo
    let stops: [BusStop]
    let lines: [BusLine]
}

struct BusInfo: Codable {
    let company: String
    let type: String
    let web: String
}

struct BusStop: Codable {
    let id: String
    let name: String
    let lat: String
    let lng: String
    let linesId: [LineId]
}

struct LineId: Codable {
    let id: String
}

struct BusLine: Codable {
    let id: String
    let name: String
    let web: String
    let updatedOn: String
    let operatesAt: String
    let direction: [BusLineDirection]
}

struct BusLineDirection: Codable {
    let name: String
    let from: String
    let to: String
    let timetable: [BusLineTimetable]
    let stopsId: [StopId]
}

struct BusLineTimetable: Codable {
    let id: String
    let name: String
    let startTime: String
    let endTime: String
    let journeyDurationMin: Int
}

struct StopId: Codable {
    let id: String
}
