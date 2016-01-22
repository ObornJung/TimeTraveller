//
//  TTLocationDate.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit
import Foundation

let kTTSecondsOneTimeZone  = 60 * 60;

typealias TTLocationData1CompletionHandler = (String?, NSError?) -> Void;

class TTLocationDate: NSObject {
    
    static let dateFormatter: NSDateFormatter = NSDateFormatter();
    
//MARK: - Private Property
    private let location: CLLocation;
    
//MARK: - Functions
    class func currentLocationDateString(date: NSDate = NSDate(), completion: TTLocationData1CompletionHandler?) {
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in
            if let currentLocation = location {
                TTLocationDate(location:currentLocation).locationDateString(date, completion: completion);
            } else {
                completion?(nil, error);
            }
        };
    }
    
    init (location: CLLocation) {
        self.location = location;
        super.init();
    }

    private func dateString(date: NSDate = NSDate()) -> String{
        let formatter = TTLocationDate.dateFormatter;
        formatter.locale     = NSLocale.currentLocale();
        formatter.dateFormat = "VVVV yyyy-MM-dd HH:mm:ss";
        formatter.timeZone = self.location.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: self.location.timeZone * kTTSecondsOneTimeZone);
        
        return formatter.stringFromDate(date);
    }
    
    func locationDateString(date: NSDate = NSDate(), completion: TTLocationData1CompletionHandler?) {
            if self.location.validPlacemarks {
                completion?(self.dateString(date), nil);
            } else {
                CLGeocoder().reverseGeocodeLocation(self.location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                    if error == nil {
                        self.location.placemarks      = placemarks;
                        self.location.validPlacemarks = true;
                        completion?(self.dateString(date), nil);
                    } else {
                        self.location.validPlacemarks = false;
                        completion?(nil, nil);
                    }
                    
                }
            }
        }
}
