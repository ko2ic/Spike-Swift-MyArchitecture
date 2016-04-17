//
//  WeatherTest.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/11.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import XCTest
import SwiftTask
@testable import Spike_Swift_MyArchitecture

class WeatherTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        WeatherFactory.destroy()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_fetchWeather(){
        class MockRepository: WeatherRepositoryImpl {
            let task = Task<Progress, WeatherEntity, Int> { progress, fulfill, reject, configure in
            }
            override func fetchWeather(cityCode: String) -> Task<Progress, WeatherEntity, Int>{
                return self.task
            }
        }

        class MockFactory: WeatherFactory {
            static let mockRepo = MockRepository()
            override class var repository: WeatherRepository! {
                return ImplicitlyUnwrappedOptional(mockRepo)
            }
        }

        let target = MockFactory.sharedInstance;
        let actual = target.fetchWeather()
        let expect = MockFactory.mockRepo.task;
        XCTAssertTrue(actual === expect)
    }
}
