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
}

struct UserService {
    private let privateKey = mountainProjectSecret
    private let scheme = "https"
    private let host = "mountainproject.com"
    private let APIPath = "/data"
    
    /// id - mountain project userID
    // TODO: Make our response return an object or error enum
    func getUser(id: String, completion: @escaping (User?) -> Void) {
        guard let url = mountainProjectURL(for: id, with: .user) else {
            // TODO: implement basic logging manager
            print("Unable to create URL")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error on request - \(String(describing: error))")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Missing Data")
                completion(nil)
                return
            }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(user)
            } catch {
                print("Unable to JSON decode")
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// Returns ticks for a user with maximium of 200 ticks. Use pageIndex to get beyond this value
    /// id - mountain project userID
    /// pageIndex - starting index of ticks
    func getTicks(id: String, pageIndex: Int = 0) {
        // TODO: DO me
    }
    
    private func mountainProjectURL(for user: String, with component: MountainProjectComponent) -> URL? {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(APIPath)/\(component.rawValue)"
        urlComponents.queryItems = [
            URLQueryItem(name: "userId", value: user),
            URLQueryItem(name: "key", value: privateKey)
        ]
        return urlComponents.url
    }
}

