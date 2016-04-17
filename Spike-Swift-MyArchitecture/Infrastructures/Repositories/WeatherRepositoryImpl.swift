//
//  WeatherRepositoryImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import SwiftTask

class WeatherRepositoryImpl: AppRepositoryImpl<WeatherEntity>, WeatherRepository {
    typealias T = WeatherEntity
    typealias Promise = Task<Progress, T, Int>

    func fetchWeather(cityCode: String) -> Promise {
        return ApiCaller.call(FetchContext(["city": cityCode]))
    }
}

private final class FetchContext: GetRestable {
    var parameters: [String: AnyObject]?

    required init() {
    }

    var path: String {
        return "/forecast/webservice/json/v1"
    }
}
