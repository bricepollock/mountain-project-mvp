//
//  StyleTableViewCell.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/5/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

struct StyleTableViewData {
    let styleText: String
    let detailText: String
    let numberOfTicks: Int
}

class StyleTableViewCell: UITableViewCell {
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var tickCount: UILabel!
    
    static let name = String(describing: StyleTableViewCell.self)
    
    static func register(in tableView: UITableView) {
        let nib = UINib(nibName: name, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func configure(data: StyleTableViewData) {
        styleLabel.text = data.styleText
        
        detailLabel.textColor = UIColor.gray
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.text = data.detailText
        
        tickCount.text = String(data.numberOfTicks)
        tickCount.font = UIFont.boldSystemFont(ofSize: 20)
        tickCount.textColor = UIColor.green
    }
}
