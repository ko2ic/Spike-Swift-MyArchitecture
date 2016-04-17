//
//  TransactionTemplateImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2016/03/25.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import RealmSwift
import Bond

class TransactionTemplateImpl: TransactionTemplate {
    func execute(errorObservable errorObservable: Observable<Exception>, doProcess: () -> ()) {
        do {
            let realm = try RealmWrapper.sharedInstance()
            realm.beginWrite()
            doProcess()
            try realm.commitWrite()
        } catch Exception.LackResources {
            print("初期化失敗")
            errorObservable.next(.LackResources)
        } catch RealmSwift.Error.FileAccess {
            print("commit失敗")
            errorObservable.next(.LackResources)
        } catch {
            print("予期せぬエラー")
            errorObservable.next(.Unexpected)
        }
    }
}
