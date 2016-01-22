//
//  CLLocation+timeZone.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/22/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import CoreLocation

typealias TTLocationDataCompletionHandler = (String?, NSError?) -> Void;

let kTTSecondsOneTimeZone  = 60 * 60;
private let kTTSecondsOneLongitude = 4.0 * 60.0;

extension CLLocation {
    
    private struct AssociatedKeys {
        static var placemarks      = "tt_placemarks"
        static var validPlacemarks = "tt_validPlacemarks"
        static let dateFormatter   = NSDateFormatter();
    }
    
    private static var dateFormatter: NSDateFormatter {
        return AssociatedKeys.dateFormatter;
    }

    private var validPlacemarks: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.validPlacemarks) as? Bool) ?? false;
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.validPlacemarks, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    private var placemarks: [CLPlacemark]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placemarks) as? [CLPlacemark];
        }
        set {
             objc_setAssociatedObject(self, &AssociatedKeys.placemarks, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    private var timeZone: Int {
        return lround(self.coordinate.longitude / 15.0);
    }
    
    //MARK: - Functions
    class func currentLocationDateString(date: NSDate = NSDate(), completion: TTLocationDataCompletionHandler?) {
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in
            if let currentLocation = location {
                currentLocation.locationDateString(date, completion: completion);
            } else {
                completion?(nil, error);
            }
        };
    }
    
    func locationDateString(date: NSDate = NSDate(), completion: TTLocationDataCompletionHandler?) {
        
        let dateStringClosure = {(date: NSDate) -> String in
            let formatter = CLLocation.dateFormatter;
            formatter.locale     = NSLocale.currentLocale();
            formatter.dateFormat = "VVVV yyyy-MM-dd HH:mm:ss";
            formatter.timeZone = self.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: self.timeZone * kTTSecondsOneTimeZone);
            
            return formatter.stringFromDate(date);
        }
        
        if self.validPlacemarks {
            completion?(dateStringClosure(date), nil);
        } else {
            CLGeocoder().reverseGeocodeLocation(self) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                if error == nil {
                    self.placemarks      = placemarks;
                    self.validPlacemarks = true;
                    completion?(dateStringClosure(date), nil);
                } else {
                    self.validPlacemarks = false;
                    completion?(nil, nil);
                }
                
            }
        }
    }
    
    /**
     计算两个location之间的时差
     
     - parameter location: 和当前比较的location(两个location必须有同步timeZoneId才能得到时区时差)
     
     - returns: 使用时区时差和绝对时差(Unit:秒)
     */
    func deltaDateToLocation(location:CLLocation) -> (Int?, Int)? {
        var deltaDateForTimeZone: Int?;
        let deltaDateForAbsolute = lround((location.coordinate.longitude - self.coordinate.longitude)
            * kTTSecondsOneLongitude);
        
        if (self.validPlacemarks && location.validPlacemarks) {
            
            let timeZone01 = self.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: self.timeZone * kTTSecondsOneTimeZone);
            let timeZone02 = location.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: location.timeZone * kTTSecondsOneTimeZone);
            deltaDateForTimeZone = timeZone02.secondsFromGMT - timeZone01.secondsFromGMT;
        }
        
        return (deltaDateForTimeZone, deltaDateForAbsolute);
    }
}