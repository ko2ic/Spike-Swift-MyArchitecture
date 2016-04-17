//
//  AppRepositoryImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/03/30.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import RealmSwift

class AppRepositoryImpl<T : Object>: AppRepository {

    func save(entity: T) {
        try! RealmWrapper.sharedInstance().add(entity)
    }

    func find() -> Results<T>? {
        return try! RealmWrapper.sharedInstance().objects(T)
    }

    func deleteAll() {
        try! RealmWrapper.sharedInstance().deleteAll()
    }
}