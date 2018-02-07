//
//  RouteTableViewCell.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

struct TickTableViewData {
    let dateTicked: String
    let routeName: String
    let tickDetailString: String?
}

class TickTableViewCell: UITableViewCell {
    @IBOutlet weak var routeNameLabel: UILabel!
    @IBOutlet weak var tickDateLabel: UILabel!
    @IBOutlet weak var routeDetailString: UILabel!
    
    static let name = String(describing: TickTableViewCell.self)
    
    static func register(in tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func configure(with data: TickTableViewData) {
        routeNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        routeNameLabel.text = data.routeName
        
        tickDateLabel.font = UIFont.systemFont(ofSize: 12)
        tickDateLabel.text = data.dateTicked
        
        if data.tickDetailString == nil {
            routeDetailString.isHidden = true
        } else {
            routeDetailString.isHidden = false
            routeDetailString.font = UIFont.systemFont(ofSize: 10)
            routeDetailString.textColor = UIColor.gray
            routeDetailString.text = data.tickDetailString
        }
    }
}
