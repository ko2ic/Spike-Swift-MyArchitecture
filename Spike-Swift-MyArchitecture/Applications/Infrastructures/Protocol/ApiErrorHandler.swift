//
//  ApiErrorHandler.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/04/07.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import Bond

protocol ApiErrorHandler {

    var unexpected: () -> () { get set }
    var notFound: () -> () { get set }

    func handle(error: Int, isCancelld: (Bool), errorObservable: Observable<Exception>)
}