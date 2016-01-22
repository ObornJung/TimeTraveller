//
//  TTLocationDateManager.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit

typealias TTLocationDataCompletionHandler = (TTLocationDate?, NSError?) -> Void;

class TTLocationDateManager: NSObject {

    private override init() {}
    
    class func dateOfCurrentLocation(completion:TTLocationDataCompletionHandler?) {
        
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in
            if let currentLocation = location {
                self.dateOfLocation(currentLocation, completion: completion);
            } else {
                completion?(nil, error);
            }
        };
    }
    
    class func dateOfLocation(location:CLLocation, completion:TTLocationDataCompletionHandler?) {
        if location.validPlacemarks {
            completion?(TTLocationDate(location: location), nil);
        } else {
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                
                if error == nil {
                    location.placemarks      = placemarks;
                    location.validPlacemarks = true;
                    completion?(TTLocationDate(location: location), nil);
                } else {
                    location.validPlacemarks = false;
                    completion?(nil, nil);
                }
                
            }
        }
    }
}
