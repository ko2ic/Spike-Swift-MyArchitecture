//
//  ForecastEntity.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Bond
import ObjectMapper
import RealmSwift
import Realm

class ForecastEntity: Object {
    private(set) dynamic var dateLabel = ""
    private(set) var telop = ""
    private(set) var date = ""
    var temperatureMin: Temperature?
    var temperatureMax: Temperature?

    convenience init(dateLabel: String, telop: String, date: String, temperatureMin: Temperature?, temperatureMax: Temperature?) {
        self.init()
        self.dateLabel = dateLabel
        self.telop = telop
        self.date = date
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
    }

    required convenience init?(_ map: Map) {
        self.init()
    }
}

extension ForecastEntity {
    class ObservableType {
        private(set) var dateLabel = Observable("")
        private(set) var telop = Observable("")
        private(set) var date = Observable("")

        init(_ entity: ForecastEntity) {
            self.dateLabel.next(entity.dateLabel)
            self.telop.next(entity.telop)
            self.date.next(entity.date)
        }
    }

    func observableType() -> ForecastEntity.ObservableType {
        return ObservableType(self)
    }
}

extension ForecastEntity: Mappable {
    func mapping(map: ObjectMapper.Map) {
        self.dateLabel <- map["dateLabel"]
        self.telop <- map["telop"]
        self.date <- map["date"]
        self.temperatureMin <- map["temperature.min"]
        self.temperatureMax <- map["temperature.max"]
    }
}
