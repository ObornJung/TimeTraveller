//
//  TTLocationDate.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit
import Foundation

let kTTSecondsOneLongitude = 4.0 * 60.0;
let kTTSecondsOneTimeZone  = 60 * 60;

class TTLocationDate {
    
    static let dateFormatter: NSDateFormatter = NSDateFormatter();
    
//MARK: -
    private let location: CLLocation;

//MARK: -
    init (location: CLLocation) {
        self.location = location;
    }

    func locationDate(date: NSDate = NSDate()) -> String{
        let formatter = TTLocationDate.dateFormatter;
        formatter.locale     = NSLocale.currentLocale();
        formatter.dateFormat = "VVVV yyyy-MM-dd HH:mm:ss";
        if let timeZoneId = self.location.timeZoneId {
            formatter.timeZone = NSTimeZone(name:timeZoneId);
        } else {
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: self.location.timeZone * kTTSecondsOneTimeZone);
        }
        
        return formatter.stringFromDate(date);
    }
}
