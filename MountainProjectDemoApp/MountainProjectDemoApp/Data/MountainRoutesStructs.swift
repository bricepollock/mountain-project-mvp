//
//  MountainRoutesStructs.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct RoutesResponse: Codable {
    let routes: [Route]
}

struct Route: Codable {
    let id: Int
    let name: String
    let type: String
}
