//
//  ThirdRouting.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import UIKit
import Bond

class ThirdRouting: UIViewController, UITableViewDelegate {
    @IBOutlet var thirdPresentor: ThirdPresentor!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.thirdPresentor.tableView.delegate = self
        thirdPresentor.setup()
        WeatherFactory.sharedInstance.errorState.observeNew { state in
            // TODO: 同じ処理があるので共通化する
            switch state {
            case .NotFound:
                let alertController = UIAlertController(title: "検索結果がありません", message: "", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Cancel) { alert in
                    print(alert)
                }
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                break
            default:
                break
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // self.thirdPresentor.fetchWeather()
        if let indexPath = self.thirdPresentor.tableView.indexPathForSelectedRow {
            self.thirdPresentor.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

//    override func viewDidDisappear(animated: Bool) {
//        thirdPresentor.tearDown()
//    }

//        // MARK: - UITableViewDataSource
//
//    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
//        return self.weather.entity.forecasts.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        let cell :UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("MyUITableViewCell",forIndexPath: indexPath)
//        cell.textLabel?.text = weather.entity.forecasts[indexPath.row].telop
//        return cell
//    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name = WeatherFactory.sharedInstance.dataSource[indexPath.section][indexPath.row]
        print(name.observableType().telop.value + " selected!")
        // self.thirdPresentor.tableView.deselectRowAtIndexPath(self.thirdPresentor.tableView.indexPathForSelectedRow!, animated: true)
        // self.thirdPresentor.tableView.reloadData()
    }
}