//
//  ApiCaller.swift
//  Spike-Swift-MyArchitecture
//
//  Created by 石井幸次 on 2016/03/30.
//  Copyright © 2016年 ko2ic. All rights reserved.
//

import SwiftTask
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ApiCaller<T: Mappable> {
    typealias Promise = Task<Progress, T, Int>

    class func call(context: Restable) -> Promise {
        let task = Promise { progress, fulfill, reject, configure in
            Alamofire.request(context)
                .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                    progress((bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) as Progress)
            }.responseObject() { (response: Response<T, NSError>) in
                    switch response.result {
                    case .Success(let entity):
                        fulfill(entity)
                    case .Failure(let error):
                        print("error:\(error)")
                        reject((response.response?.statusCode)!)
                    }
            }
        }
        return task
    }
}