//
//  TransactionTemplate.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/07.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import Bond

protocol TransactionTemplate {
    func execute(errorObservable errorObservable: Observable<Exception>, doProcess: () -> ())
}