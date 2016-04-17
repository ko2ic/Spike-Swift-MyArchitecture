//
//  SecondPresentor.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import UIKit

class SecondPresentor: NSObject {
    @IBOutlet weak var cityCode: UITextField!

    @IBOutlet weak var cityCodeLabel: UILabel!

    func setup() {
        WeatherFactory.sharedInstance.cityCode.bidirectionalBindTo(cityCode.bnd_text)
        WeatherFactory.sharedInstance.cityCode.bindTo(cityCodeLabel.bnd_text)
    }

    func toThird() {
        WeatherFactory.sharedInstance.toThird()
    }
}
