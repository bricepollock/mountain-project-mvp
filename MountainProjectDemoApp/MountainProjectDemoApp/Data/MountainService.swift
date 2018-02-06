//
//  UserService.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/5/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

enum MountainProjectComponent: String {
    case ticks = "get-ticks"
    case user = "get-user"
    case routes = "get-routes"
}

struct MountainService {
    private let privateKey = mountainProjectSecret
    private let scheme = "https"
    private let host = "mountainproject.com"
    private let APIPath = "/data"
    private let networkManager = NetworkManager()
    
    /// id - mountain project userID
    // TODO: Make our response return an object or error enum
    func getUser(id: String, completion: @escaping (User?) -> Void) {
        let idParam = URLQueryItem(name: "userId", value: id)
        guard let url = mountainProjectURL(for: [idParam], with: .user) else {
            // TODO: implement basic logging manager
            print("Unable to create URL")
            return
        }
        networkManager.makeURLRequest(for: url, with: completion)
    }
    
    /// Returns ticks for a user with maximium of 200 ticks. Use pageIndex to get beyond this value
    /// id - mountain project userID
    /// pageIndex - starting index of ticks
    func getTicks(id: String, pageIndex: Int = 0, completion: @escaping (TickResponse?) -> Void) {
        let idParam = URLQueryItem(name: "userId", value: id)
        guard let url = mountainProjectURL(for: [idParam], with: .ticks) else {
            // TODO: implement basic logging manager
            print("Unable to create URL")
            return
        }
        networkManager.makeURLRequest(for: url, with: completion)
    }
    
    // limit of 100 routes
    func getRoutes(routeList: [Int], completion: @escaping (RoutesResponse?) -> Void) {
        if routeList.count > 100 {
            print("Warning, truncating number of routes to 100 to meet API requirement")
        } else if routeList.isEmpty {
            print("empty route list. no need to talk to server")
            completion(nil)
            return
        }
        let routeListString = routeQuery(from: routeList)
        let routeParam = URLQueryItem(name: "routeIds", value: routeListString)
        guard let url = mountainProjectURL(for: [routeParam], with: .routes) else {
            // TODO: implement basic logging manager
            print("Unable to create URL")
            return
        }
        networkManager.makeURLRequest(for: url, with: completion)
    }
    
    internal func routeQuery(from routeList: [Int]) -> String {
        let queryRoutes = routeList.count > 100 ? Array(routeList[..<100]) : routeList
        return queryRoutes.reduce("") { (current, next) -> String in
            let routeId = String(next)
            guard !current.isEmpty else { return routeId }
            return current + "," + routeId
        }
    }
    
    private func mountainProjectURL(for queries: [URLQueryItem], with component: MountainProjectComponent) -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(APIPath)/\(component.rawValue)"
        urlComponents.queryItems = queries + [
            URLQueryItem(name: "key", value: privateKey)
        ]
        return urlComponents.url
    }
}

