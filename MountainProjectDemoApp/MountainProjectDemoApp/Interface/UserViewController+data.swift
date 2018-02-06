//
//  UserViewController+data.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

extension UserViewController {
    
    func requestData(completion: @escaping (User?, TickResponse?, [Int: Route]) -> Void) {
        
        let requestGroup = DispatchGroup()
        var user: User? = nil
        var ticks: TickResponse? = nil
        var routeMap: [Int: Route] = [:]
        
        requestGroup.enter()
        mountainService.getUser(id: mountainProjectUserId) { (response) in
            defer { requestGroup.leave() }
            user = response
        }
        
        requestGroup.enter()
        mountainService.getTicks(id: mountainProjectUserId) { [weak self] (response) in
            defer { requestGroup.leave() }
            ticks = response
            
            guard let ticks = ticks else { return }
            let routesForTicks = ticks.ticks.map({ (tick) -> Int in
                tick.routeId
            })
            
            guard let `self` = self else { return }
            requestGroup.enter()
            self.mountainService.getRoutes(routeList: routesForTicks) { (response) in
                defer { requestGroup.leave() }
                response?.routes.forEach({ (route) in
                    routeMap[route.id] = route
                })
            }
        }
        
        requestGroup.wait()
        completion(user, ticks, routeMap)
    }
}
