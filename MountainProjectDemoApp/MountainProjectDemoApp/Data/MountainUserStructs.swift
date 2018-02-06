//
//  UserServiceStruct.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/5/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let styles: [String: StyleDetail]
}

struct StyleDetail: Codable {
    let lead: String
    let follow: String
}

// TODO: Incorpoarte this for string convenience to help with type safety
enum Style: String {
    case trad = "Trad"
    case sport = "Sport"
    case boulder = "Boulders"
    case aid = "Aid"
    case ice = "Ice"
    case mixed = "Mixed"
}

