//
//  TTGeoSeivice.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/7/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit
import Foundation

class TTGeoService: TTBaseService {
    
    class func queryGeoInfo(location: CLLocation, result: ((_: TTGeoModel?) -> ())?) {
        let geoService = "http://api.geonames.org/timezoneJSON";
        let parameters = ["lat": "\(location.coordinate.latitude)",
                          "lng": "\(location.coordinate.longitude)",
                     "username": "ObornJung"];
        super.request(.GET, geoService, parameters: parameters).responseJSON { response -> Void in
            if response.result.isSuccess {
                if let responseDic = response.result.value as? NSDictionary {
                    let geoModel = TTGeoModel();
                    geoModel.timezoneId = responseDic["timezoneId"] as? String;
                    result?(geoModel);
                }
            } else {
                OBLog("\(response.result.error)")
            }
        }
    }
}
