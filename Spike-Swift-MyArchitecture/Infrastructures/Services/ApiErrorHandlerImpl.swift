//
//  ApiErrorHandlerImpl.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2016/03/25.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import Foundation
import Bond

class ApiErrorHandlerImpl: ApiErrorHandler {

    var unexpected = { }
    var notFound = { }

    func handle(error: Int, isCancelld: (Bool), errorObservable: Observable<Exception>) {
        switch error {
        case 404:
            notFound()
            errorObservable.next(.NotFound)
        default:
            unexpected()
            errorObservable.next(.Unexpected)
            break
        }
    }
}
