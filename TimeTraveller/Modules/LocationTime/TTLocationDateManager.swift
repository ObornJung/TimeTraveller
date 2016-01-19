//
//  TTLocationDateManager.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit

class TTLocationDateManager {

    private init() {}
    
    class func dateOfCurrentLocation(locationDate:((_: TTLocationDate?) -> ())?) {
        
        TTLocationCenter.currentLocation { (location) -> () in
            if let currentLocation = location {
                self.dateOfLocation(currentLocation, locationDate: locationDate);
            }
        }
    }
    
    class func dateOfLocation(location:CLLocation, locationDate:((_: TTLocationDate?) -> ())?) {
        if location.isSync {
            locationDate?(TTLocationDate(location: location));
        } else {
            TTGeoService.queryGeoInfo(location) { (model: TTGeoModel?) -> () in
                if let geoModel = model {
                    location.timeZoneId = geoModel.timezoneId;
                    location.isSync = true;
                    locationDate?(TTLocationDate(location: location));
                } else {
                    location.isSync = false;
                }
            }
        }
    }
}
