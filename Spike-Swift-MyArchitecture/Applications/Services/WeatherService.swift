//
//  WeatherFacade.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

//import RealmSwift
import SwiftTask

class WeatherService {

//    // TODO: static や singleton だとまずい
//    private static var disposable :DisposableType?
//
//    func register() {
//        WeatherService.disposable = NSNotificationCenter.defaultCenter().bnd_notification(NSStringFromClass(WeatherRepository.self), object: nil)
//            .observe { notification in
//
//                // TODO: 別スレッドにする場合はここでやる？modelでもOKにする？ bondの機能を使わないで、NSNotificationCenterにNSOperationQueueをしたほうがいいかな？
//                //let queue = dispatch_queue_create("Sample", DISPATCH_QUEUE_SERIAL)
//                //dispatch_async(queue) { () in
//                //    print("thread = \(NSThread.currentThread())")
//                //}
//
//                if let userInfo  = notification.userInfo as! [String : WeatherEntity]! {
//                    do {
//                        let realm = try RealmFactory.sharedInstance();
//                        realm.beginWrite()
//                        WeatherFactory.sharedInstance().changeForecasts(userInfo)
//                        try realm.commitWrite()
//                    } catch Exception.RealmInit {
//                        // TODO: 回復可能なのでユーザに再度お願いする？
//                        print("失敗")
//                    } catch RealmSwift.Error.FileAccess {
//                        // TODO: commit失敗はこれ？commit失敗は回復可能だろうからRealmInitと同じようにする
//                        print("失敗")
//                    } catch {
//                        // TODO: 回復不能はどうする？
//                        print("失敗")
//                    }
//                }
//            }
//    }
//
//    func unregister(){
//        WeatherService.disposable!.dispose()
//    }

    private let locator: ServiceLocator!
    private let weather: Weather!

    init(locator: ServiceLocator = ServiceLocatorImpl.sharedInstance, weather: Weather = WeatherFactory.sharedInstance) {
        self.locator = locator
        self.weather = weather
    }

    func fetchWeather() {
        let task = weather.fetchWeather()
        task.success { [unowned self] entity -> Void in
            entity.cityCode = self.weather.cityCode.value!
            let tx: TransactionTemplate = self.locator.lookup()
            tx.execute(errorObservable: self.weather.errorState) {
                self.weather.changeForecasts(entity)
            }
        }.failure { error, isCancelled in
            var handler: ApiErrorHandler = self.locator.lookup()
            handler.notFound = {
                self.weather.clearForecasts()
            }
            handler.handle(error!, isCancelld: isCancelled, errorObservable: self.weather.errorState)
        }
    }

    func fetchWeatherInApp() {
        weather.fetchWeatherInApp()
    }
}
