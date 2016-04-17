//
//  FirstRounting.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved.
//

import UIKit

class FirstRounting: UIViewController {
    @IBOutlet var firstPresentor: FirstPresentor!

    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherFactory.sharedInstance.entity.observableForecasts.observeNew { forecasts in
            print(forecasts)
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.firstPresentor.fetchWeatherInApp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
    }
}
