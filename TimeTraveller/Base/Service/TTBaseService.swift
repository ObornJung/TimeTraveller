//
//  TTBaseService.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/15/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import Foundation
import Alamofire

class TTBaseService: NSObject {
    
    class func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil)
        -> Request {
            
        return Alamofire.request(.GET, URLString, parameters: parameters, encoding: encoding, headers: headers);
    }
}
