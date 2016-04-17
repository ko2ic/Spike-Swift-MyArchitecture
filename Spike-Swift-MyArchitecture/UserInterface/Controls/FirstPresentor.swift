//
//  FirstPresentor.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import UIKit

class FirstPresentor: NSObject {
    func fetchWeatherInApp() {
        let service = WeatherService()
        service.fetchWeatherInApp()
    }
}
