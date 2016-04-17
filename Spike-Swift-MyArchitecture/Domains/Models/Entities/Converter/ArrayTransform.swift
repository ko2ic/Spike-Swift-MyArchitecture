//
//  ArrayTransform.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import RealmSwift
import ObjectMapper

class ArrayTransform<T: RealmSwift.Object where T: Mappable>: TransformType {
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>

    func transformFromJSON(value: AnyObject?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as! Array<AnyObject>? {
            for entry in tempArr {
                let mapper = Mapper<T>()
                let model: T = mapper.map(entry)!
                result.append(model)
            }
        }
        return result
    }

    func transformToJSON(value: Object?) -> JSON? {
        let mapper = Mapper<T>()
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json)
            }
        }
        return results
    }
}
