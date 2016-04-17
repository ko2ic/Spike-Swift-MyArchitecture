//
//  WeatherEntity.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Bond
import ObjectMapper
import RealmSwift

class WeatherEntity: Object {
    dynamic var cityCode = ""
    dynamic var title = ""
    var forecasts = List<ForecastEntity>()

    override static func primaryKey() -> String? {
        return "cityCode"
    }

    required convenience init?(_ map: Map) {
        self.init()
    }
}

extension WeatherEntity {
    class ObservableType {
        let observableForecasts = ObservableArray<ForecastEntity>()
        let observableTitle: Observable<String> = Observable("")

        init(entity: WeatherEntity) {
            self.changeForecasts(entity.forecasts)
            self.observableTitle.next(entity.title)
        }

        func changeForecasts(forecasts: List<ForecastEntity>) {
            self.observableForecasts.removeAll()
            let entities = self.convertToArray(forecasts)
            self.observableForecasts.extend(entities)
        }

        func clearForecasts() {
            self.observableForecasts.removeAll()
        }

        func changeTitle(title: String) {
            self.observableTitle.next(title)
        }

        private func convertToArray(list: List<ForecastEntity>) -> [ForecastEntity] {
            var entities = [ForecastEntity]()
            list.forEach { entity in
                entities.append(entity)
            }
            return entities
        }
    }

    func observableType() -> WeatherEntity.ObservableType {
        return ObservableType(entity: self)
    }
}

extension WeatherEntity: Mappable {
    func mapping(map: ObjectMapper.Map) {
        self.title <- map["title"]
        self.forecasts <- (map["forecasts"], ArrayTransform<ForecastEntity>())
    }
}
