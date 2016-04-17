//
//  AppRepository.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/03/30.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import RealmSwift

protocol  AppRepository: Storable {
    associatedtype T: Object
    func save(entity: T)
    func find() -> Results<T>?
    func deleteAll()
}