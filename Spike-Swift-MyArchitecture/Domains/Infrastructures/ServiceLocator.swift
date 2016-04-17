//
//  ServiceLocator.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/11.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation

protocol ServiceLocator {

    static var sharedInstance: ServiceLocator { get }

    func add<T>(recipe: () -> T)

    func lookup<T>() -> T
}