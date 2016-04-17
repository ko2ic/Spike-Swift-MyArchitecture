//
//  RealmWrapper.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import RealmSwift

class RealmWrapper {

    private static var realmPerThread: Dictionary < String, Realm > = [:]

    private init() { }

    static func sharedInstance() throws -> Realm {
        var realm = self.realmPerThread[self.threadId()]
        if realm == nil {
            do {
                realm = try Realm()
                self.realmPerThread[threadId()] = realm
            } catch let error as RealmSwift.Error {
                print("Realm init error: \(error)")
                switch error {
                case .FileAccess:
                    throw Exception.LackResources
                case .Fail:
                    throw Exception.Unexpected
                default:
                    throw Exception.ProgramError
                }
            } catch {
                print("Realm init error: unexpected")
                throw Exception.Unexpected
            }
        }
        return realm!
    }

    static func destroy() {
        self.realmPerThread.removeValueForKey(self.threadId())
    }

    private static func threadId() -> String {
        let id = "\(NSThread.currentThread())"
        print(id)
        return id
    }
}
