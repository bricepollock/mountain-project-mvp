//
//  MountainTicksStructs.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct TickResponse: Codable {
    let ticks: [Tick]
}

struct Tick: Codable {
    let date: String
    let routeId: Int
    let pitches: Int
    let leadStyle: String
}
