//
//  TicksViewController.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

class TicksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let processor = TicksViewDataProcessor()
    var routes: [Int: Route]!
    var ticks: [Tick]!
    
    var tickData = [TickTableViewData]()
    
    static func create(for ticks: [Tick], with routes: [Int: Route]) -> TicksViewController {
        let viewController: TicksViewController = createInstanceFromStoryboard()
        viewController.routes = routes
        viewController.ticks = ticks
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Style Tick List"
        
        // table view initialization
        TickTableViewCell.register(in: tableView)
        
        tickData = processor.tickCellData(from: ticks, with: routes)
        
        // TODO: show some empty state if no ticks
        tableView.reloadData()
    }
}

extension TicksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: TickTableViewCell.name, for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TickTableViewCell.name) as? TickTableViewCell else {
            print("cannot dequeu cell")
            return UITableViewCell()
        }
        guard indexPath.row < tickData.count else {
            print("Exceeds bounds!!")
            return UITableViewCell()
        }
        
        // TODO show number of ticks in this category
        cell.configure(with: tickData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: show all ticked climbs in this category
    }
}

extension TicksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickData.count
    }
}
