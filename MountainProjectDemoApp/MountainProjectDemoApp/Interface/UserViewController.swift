//
//  ViewController.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/5/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var user: User?
    private let userService = UserService()
    private let dataProcessor = UserViewDataProcessor()
    private var styleData = [StyleTableViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // table view initialization
        
        StyleTableViewCell.register(in: tableView)
        
        // TODO: Show a spinner while this is loading
        userService.getUser(id: mountainProjectUserId) { [weak self] (user) in
            guard let user = user else {
                // TODO: show error
                print("Unable to get error")
                return
            }
            
            // do processing off main thread
            let styleData = self?.dataProcessor.createStyleData(from: user)
            
            // update UI on main thread
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.user = user
                
                guard let styleData = styleData else { return }
                self.styleData = styleData
                self.tableView.reloadData()
            }
        }
    }
}


extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: StyleTableViewCell.name, for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StyleTableViewCell.name) as? StyleTableViewCell else {
            print("cannot dequeu cell")
            return UITableViewCell()
        }
        guard indexPath.row < styleData.count else {
            print("Exceeds bounds!!")
            return UITableViewCell()
        }
        
        // TODO show number of ticks in this category
        cell.configure(data: styleData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: show all ticked climbs in this category
    }
}

extension UserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styleData.count
    }
}
