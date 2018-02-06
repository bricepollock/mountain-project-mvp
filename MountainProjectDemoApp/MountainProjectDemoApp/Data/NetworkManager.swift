//
//  NetworkManager.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

struct NetworkManager {
    func makeURLRequest<T: Codable>(for url: URL, with completion: @escaping (T?) -> Void) {
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
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object)
            } catch {
                print("Unable to JSON decode")
                completion(nil)
            }
        }
        task.resume()
    }
}
