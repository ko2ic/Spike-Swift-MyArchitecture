//
//  ServiceLocatorImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/02.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation

class ServiceLocatorImpl: ServiceLocator {

    private lazy var container: Dictionary < String, () -> Any > = [:]

    private static let singleton = ServiceLocatorImpl()

    static var sharedInstance: ServiceLocator { return singleton }

    private init() {
    }

    func add<T>(recipe: () -> T) {
        let key = typeName(T)
        container[key] = recipe
    }

    func lookup<T>() -> T {
        let key = typeName(T)
//        guard let recipe = container[key] else {
//            return nil
//        }
        return container[key]!() as! T
    }

    private func typeName<T>(some: T.Type) -> String {
        // TODO: 命名規約で動作
        return "\(some)".stringByReplacingOccurrencesOfString("Impl", withString: "")
    }
}
