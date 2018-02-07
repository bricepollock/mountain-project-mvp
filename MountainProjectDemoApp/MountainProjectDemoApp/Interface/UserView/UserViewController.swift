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
    private var ticks: TickResponse?
    private var routes: [Int: Route]?
    
    private let dataProcessor = UserViewDataProcessor()
    private var styleData = [StyleTableViewData]()
    internal let mountainService = MountainService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // table view initialization
        StyleTableViewCell.register(in: tableView)
        
        // TODO: Show a spinner while this is loading
        requestData { (user, tickResponse, routeMap) in
            guard let user = user, let tickResponse = tickResponse else {
                print("Unable to get error")
                
                DispatchQueue.main.async { [weak self] in
                    let alertController = UIAlertController(title: "Whoops!", message: "We were unable to communicate with Mountain Project. Please try again later", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                    }))
                    self?.present(alertController, animated: true, completion: nil)
                }
                return
            }
            
            // do processing off main thread
            let styleData = self.dataProcessor.createStyleData(from: user, with: tickResponse, with: routeMap)
            
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.user = user
                self.ticks = tickResponse
                self.routes = routeMap
                
                self.navigationItem.title = user.name
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
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard indexPath.row < styleData.count else {
            print("Exceeds bounds!!")
            return
        }
        
        guard let ticks = ticks, let routes = routes else {
            print("inadequate data")
            return
        }
        
        let style = styleData[indexPath.row].styleText
        let ticksForStyle = dataProcessor.findTicks(for: style, given: ticks, with: routes)
        let ticksController = TicksViewController.create(for: ticksForStyle, with: routes)
        self.navigationController?.pushViewController(ticksController, animated: true)
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
