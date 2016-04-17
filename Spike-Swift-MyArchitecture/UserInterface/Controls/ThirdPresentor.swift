//
//  ThirdPresentor.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import UIKit
import Bond

class ThirdPresentor: NSObject {
    @IBOutlet weak var tableView: UITableView!

    func setup() {
        // WeatherService().register()
        let service = WeatherService()
        service.fetchWeather()
        WeatherFactory.sharedInstance.dataSource.bindTo(self.tableView) { (indexPath, dataSource, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCellWithIdentifier("MyUITableViewCell", forIndexPath: indexPath)
            let forecast = dataSource[indexPath.section][indexPath.row]
            forecast.observableType().telop.bindTo(cell.textLabel!.bnd_text).disposeIn(cell.bnd_bag)
            return cell
        }
    }

//    func tearDown() {
//      WeatherService().unregister()
//    }

//    func fetchWeather() {
//        let service = WeatherService()
//        service.fetchWeather()
//    }
}

class MyUITableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        bnd_bag.dispose()
    }
}
