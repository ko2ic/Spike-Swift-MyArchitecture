//
//  AppRepositoryWrapper.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved.
//

import SwiftTask
import RealmSwift

class AppRepositoryWrapper<T : Object>: AppRepository {

    private let saveClosure: T -> ()
    private let findClosure: () -> Results<T>?
    private let deleteAllClosure: () -> ()

    init < R: AppRepository where R.T == T > (_ repository: R) {
        self.saveClosure = repository.save
        self.findClosure = repository.find
        self.deleteAllClosure = repository.deleteAll
    }

    func save(entity: T) {
        self.saveClosure(entity)
    }

    func find() -> Results<T>? {
        return self.findClosure()
    }

    func deleteAll() {
        self.deleteAllClosure()
    }
}
