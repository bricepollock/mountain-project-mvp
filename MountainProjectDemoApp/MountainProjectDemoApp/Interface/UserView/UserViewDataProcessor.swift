//
//  UserViewController+factory.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/5/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct UserViewDataProcessor {
    func createStyleData(from user: User, with ticks: TickResponse, with routeMap: [Int: Route]) -> [StyleTableViewData] {
        return user.styles.keys.flatMap { (styleKey) in
            guard let styleDetails = user.styles[styleKey] else { return nil }
            guard let styleDetailText = textFromStyleDetail(detail: styleDetails) else { return nil }
            let ticksForStyle = findTicks(for: styleKey, given: ticks, with: routeMap)
            return StyleTableViewData(styleText: styleKey, detailText: styleDetailText, numberOfTicks: ticksForStyle.count)
        }
    }
    
    func textFromStyleDetail(detail: StyleDetail) -> String? {
        let followText = "Follow: \(detail.follow)"
        if detail.lead.isEmpty {
            if detail.follow.isEmpty {
                return nil
            } else {
                return followText
            }
        } else {
            let leaderText = "Lead: \(detail.lead)"
            if !detail.follow.isEmpty {
                return  leaderText + ", " + followText
            } else {
                return leaderText
            }
        }
    }
    
    func findTicks(for style: String, given ticks: TickResponse, with routeMap: [Int: Route]) -> [Tick] {
        return ticks.ticks.filter { (tick) -> Bool in
            guard let routeStyle = routeMap[tick.routeId]?.type else { return false}
            return style == routeStyle
        }
    }
}
