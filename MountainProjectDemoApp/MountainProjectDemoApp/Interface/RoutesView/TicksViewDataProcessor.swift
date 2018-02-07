//
//  TicksViewDataProcessor.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct TicksViewDataProcessor {
    func tickCellData(from ticks: [Tick], with routes: [Int: Route]) -> [TickTableViewData] {
        return ticks.flatMap({ (tick) -> TickTableViewData? in
            guard let route = routes[tick.routeId] else { return nil }
            let detailStr = tickDetails(from: tick, with: route)
            return TickTableViewData(dateTicked: tick.date, routeName: route.name, tickDetailString: detailStr)
        })
    }
    
    func tickDetails(from tick: Tick, with route: Route) -> String? {
        let leadStyle = tick.leadStyle
        let routeStyle = route.type
        
        let leadStyleStr = "Send Style: \(leadStyle)"
        if routeStyle.isEmpty {
            if leadStyle.isEmpty {
                return nil
            } else {
                return leadStyleStr
            }
        } else {
            let routeStyleStr = "Route Style: \(routeStyle)"
            if leadStyle.isEmpty {
                return routeStyleStr
            } else {
                return routeStyleStr + ", " + leadStyleStr
            }
        }
    }
    
}
