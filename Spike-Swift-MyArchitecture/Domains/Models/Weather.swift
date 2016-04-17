//
//  Weather.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Bond
import SwiftTask

class Weather {
    // TODO: 二箇所に記述している
    typealias Promise = Task<Progress, WeatherEntity, Int>

    private(set) var repository: WeatherRepository!
    private(set) var entity: WeatherEntity.ObservableType!
    private(set) var dataSource: ObservableArray<ObservableArray<ForecastEntity>>!
    private(set) var cityCode: Observable<String?>!
    private(set) var transitionState: Observable<TransitionState>!
    private(set) var errorState: Observable<Exception>!

    // private init() { }

    func toThird() {
        if errorState.value == .None {
            self.transitionState.next(TransitionState.Start)
        } else {
            self.errorState.next(.NotFound)
        }
    }

    func fetchWeather() -> Promise {
        return repository.fetchWeather(cityCode.value!)
    }

//    func changeForecasts(userInfo : [String : WeatherEntity]) {
//        if let entity :WeatherEntity = userInfo["entity"] {
//            self.entity.changeForecasts(entity.forecasts)
//            let repository = WeatherRepository()
//            repository.deleteAll()
//            repository.save(entity)
//            //self.transitionState.next(TransitionState.Search)
//        }
//    }

    func changeForecasts(entity: WeatherEntity) {
        self.entity.changeForecasts(entity.forecasts)
        repository.deleteAll()
        repository.save(entity)
    }

    func clearForecasts() {
        self.entity.clearForecasts()
    }

    func fetchWeatherInApp() {
        if let entity: WeatherEntity = repository.find()!.last {
            self.entity.changeTitle(entity.title)
            self.entity.changeForecasts(entity.forecasts)
        }
    }
}

class WeatherFactory {
    private static var weather: Weather?

    static var sharedInstance: Weather {
        if let cache = self.weather {
            return cache
        }
        self.weather = self.instance
        self.weather!.repository = self.repository
        self.weather!.entity = WeatherEntity().observableType()
        self.weather!.cityCode = Observable<String?>("130010")
        self.weather!.transitionState = Observable<TransitionState>(.None)
        self.weather!.errorState = Observable<Exception>(.None)
        self.weather!.dataSource = ObservableArray<ObservableArray<ForecastEntity>>([self.weather!.entity.observableForecasts])
        return self.weather!
    }

    class var repository: WeatherRepository! {
        let locator = ServiceLocatorImpl.sharedInstance
        let repository: WeatherRepository = locator.lookup()
        return ImplicitlyUnwrappedOptional(repository)
    }

    class var instance: Weather {
        return Weather()
    }

    static func destroy() {
        self.weather = nil
    }
}
