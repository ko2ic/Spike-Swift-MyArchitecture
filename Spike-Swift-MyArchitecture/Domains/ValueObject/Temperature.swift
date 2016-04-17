//
//  Temperature.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Bond
import ObjectMapper
import RealmSwift
import Realm

class Temperature: Object {
    private(set) var celsius = ""
    private(set) var fahrenheit = ""

    convenience init(celsius: String, fahrenheit: String) {
        self.init()
        self.celsius = celsius
        self.fahrenheit = fahrenheit
    }
    required convenience init?(_ map: Map) {
        self.init()
    }
}

extension Temperature {
    class ObservableType {
        private(set) var celsius = Observable("")
        private(set) var fahrenheit = Observable("")

        init(_ type: Temperature) {
            self.celsius.next(type.celsius)
            self.fahrenheit.next(type.fahrenheit)
        }
    }

    func observableType() -> Temperature.ObservableType {
        return ObservableType(self)
    }
}

extension Temperature: Mappable {
    func mapping(map: ObjectMapper.Map) {
        self.celsius <- map["celsius"]
        self.fahrenheit <- map["fahrenheit"]
    }
}
