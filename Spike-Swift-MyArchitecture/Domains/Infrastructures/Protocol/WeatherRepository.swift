//
//  WeatherRepository.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/02.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import SwiftTask
import RealmSwift

protocol WeatherRepository: Storable {

    func fetchWeather(cityCode: String) -> Task<Progress, WeatherEntity, Int>
    func save(entity: WeatherEntity)
    func find() -> Results<WeatherEntity>?
    func deleteAll()
}