//
//  Restable.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import Alamofire

protocol Restable: URLRequestConvertible {
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: AnyObject]? { get set }
    var method: Method { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String]? { get }

    init()
    init(_ parameters: [String: AnyObject])
}

extension Restable {
    var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: baseUrl)!
        let request = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        request.HTTPMethod = self.method.rawValue
        request.allHTTPHeaderFields = headers
        return encoding.encode(request, parameters: parameters).0
    }
}

extension Restable {
    init(_ parameters: [String: AnyObject]) {
        self.init()
        self.parameters = parameters
        print(self.URLRequest.debugDescription)
    }
}

extension Restable {
    var headers: [String: String]? {
        return nil
    }

    var baseUrl: String {
        return "http://weather.livedoor.com"
    }
}

protocol GetRestable: Restable {
}

extension GetRestable {
    var method: Alamofire.Method {
        return .GET
    }

    var encoding: Alamofire.ParameterEncoding {
        return .URL
    }
}
