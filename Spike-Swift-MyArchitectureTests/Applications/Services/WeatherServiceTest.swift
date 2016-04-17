//
//  WeatherServiceTest.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/11.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import XCTest
import SwiftTask
import Bond

@testable import Spike_Swift_MyArchitecture

class WeatherServiceTest: XCTestCase {

    override func setUp() {
        super.setUp()
        WeatherFactory.destroy()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_fetchWeatherInApp() {

        class MockWeather: Weather {
            var wasCalled = false
            override func fetchWeatherInApp() {
                self.wasCalled = true
            }
        }

        let mock = MockWeather()

        let target = WeatherService(weather: mock)
        target.fetchWeatherInApp()
        XCTAssertTrue(mock.wasCalled);
    }

    func test_fetchWeather_success() {
        class MockWeather: Weather {
            var wasCalled = false
            typealias Promise = Task<Progress, WeatherEntity, Int>
            override func fetchWeather() -> Promise {
                let task = Promise { progress, fulfill, reject, configure in
                    fulfill(WeatherEntity())
                }
                return task
            }
            override func changeForecasts(entity: WeatherEntity) {
                wasCalled = true
            }
        }
        class MockFactory: WeatherFactory {
            override class var instance: Weather {
                return MockWeather()
            }
        }

        class MockTx: TransactionTemplateImpl {
            override func execute(errorObservable errorObservable: Observable<Exception>, doProcess: () -> ()) {
                doProcess()
            }
        }

        class MockLocator: ServiceLocator {
            private let tx = MockTx()
            static var sharedInstance: ServiceLocator {
                return MockLocator()
            }
            func add<T>(recipe: () -> T) { }

            func lookup<MockTx>() -> MockTx {
                return self.tx as! MockTx
            }
        }

        let target = WeatherService(locator: MockLocator.sharedInstance, weather: MockFactory.sharedInstance)
        target.fetchWeather()

        XCTAssertTrue((MockFactory.sharedInstance as! MockWeather).wasCalled)
    }

    func test_fetchWeather_failure() {

        class MockErrorHandler: ApiErrorHandlerImpl {
            var wasCalled = true
            override func handle(error: Int, isCancelld: (Bool), errorObservable: Observable<Exception>) {
                XCTAssertTrue(error == 404)
                XCTAssertTrue(errorObservable.value == Exception.None)
                wasCalled = true
            }
        }

        class MockLocator: ServiceLocator {
            let errorHandler = MockErrorHandler()
            static var sharedInstance: ServiceLocator {
                return MockLocator()
            }
            func add<T>(recipe: () -> T) { }

            func lookup<MockErrorHandler>() -> MockErrorHandler {
                return self.errorHandler as! MockErrorHandler
            }
        }

        class MockWeather: Weather {
            var wasCalled = false
            typealias Promise = Task<Progress, WeatherEntity, Int>
            override func fetchWeather() -> Promise {
                let task = Promise { progress, fulfill, reject, configure in
                    reject(404)
                }
                return task
            }
        }

        class MockFactory: WeatherFactory {
            override class var instance: Weather {
                return MockWeather()
            }
        }

        let locator = MockLocator.sharedInstance
        let target = WeatherService(locator: locator, weather: MockFactory.sharedInstance)
        target.fetchWeather()

        XCTAssertTrue((locator as! MockLocator).errorHandler.wasCalled)
    }
}