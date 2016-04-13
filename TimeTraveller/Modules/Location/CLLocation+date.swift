//
//  CLLocation+timeZone.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/22/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import CoreLocation

typealias TTLocationDataCompletionHandler = (String?, NSError?) -> Void;

typealias TTUpdatePlacemarksClosure = ([CLPlacemark]?, NSError?) -> Void;

let kTTSecondsOneTimeZone  = 60 * 60;
private let kTTSecondsOneLongitude = 4.0 * 60.0;

extension CLLocation {
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude);
    }
    
    private struct AssociatedKeys {
        static var placemarks      = "tt_placemarks"
        static var validPlacemarks = "tt_validPlacemarks"
        static let dateFormatter   = NSDateFormatter();
    }
    
    private static var dateFormatter: NSDateFormatter {
        return AssociatedKeys.dateFormatter;
    }

    private(set) var validPlacemarks: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.validPlacemarks) as? Bool) ?? false;
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.validPlacemarks, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    var placemarks: [CLPlacemark]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placemarks) as? [CLPlacemark];
        }
        set {
             objc_setAssociatedObject(self, &AssociatedKeys.placemarks, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    var timeZone: Int {
        return lround(self.coordinate.longitude / 15.0);
    }
    
    //MARK: - Functions
    /**
    获取给定日期当前地点的绝对时间
    
    - parameter date:       日期，默认值当前时间
    - parameter completion: 计算完成的闭包
    */
    class func currentAbsoluteLocationDateString(date: NSDate, completion: TTLocationDataCompletionHandler?) {
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in
            if let currentLocation = location {
                completion?(currentLocation.locationDateString(date), nil);
            } else {
                completion?(nil, error);
            }
        };
    }
    
    /**
     计算当前位置的时区时间
     
     - parameter date:       日期，默认值当前时间
     - parameter showTZName: 是否显示时区名
     - parameter completion: 计算完成的闭包
     */
    class func currentLocationDateString(date: NSDate, showTZName: Bool = false, completion: TTLocationDataCompletionHandler?) {
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in
            if let currentLocation = location {
                currentLocation.updatePlacemarks({[weak currentLocation] (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                    completion?(currentLocation?.zoneTimeDateString(date, showTZName), error);
                });
            } else {
                completion?(nil, error);
            }
        };
    }
    
    /**
     更新location的地理标准信息
     
     - parameter completion: 地理标准信息更新完毕回调
     */
    func updatePlacemarks(completion: TTUpdatePlacemarksClosure?) {
        
        CLGeocoder().reverseGeocodeLocation(self) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            self.validPlacemarks = error == nil;
            if self.validPlacemarks {
                self.placemarks      = placemarks;
            }
            completion?(placemarks, error);
        }
    }
    
     /**
     获取给定日期的绝对时间
     
     - parameter date: 日期，默认值当前时间
     
     - returns: 给定日期的绝对时间
     */
    func locationDateString(date: NSDate) -> String {
        let offset = self.coordinate.longitude * kTTSecondsOneLongitude;
        let absoluteDate = NSDate(timeInterval: offset, sinceDate: date);
        let formatter = CLLocation.dateFormatter;
        formatter.locale     = NSLocale.currentLocale();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        formatter.timeZone = NSTimeZone(forSecondsFromGMT:0);
        
        return formatter.stringFromDate(absoluteDate);
    }
    
    /**
     计算给定时间的当地时区时间
     
     - parameter date:       日期，默认值当前时间
     - parameter showTZName: 是否显示时区名
     */
    func zoneTimeDateString(date: NSDate, _ showTZName: Bool = false) -> String {
        
        let formatter = CLLocation.dateFormatter;
        formatter.locale     = NSLocale.currentLocale();
        formatter.dateFormat = showTZName ? "VVVV: yyyy-MM-dd HH:mm:ss" : "yyyy-MM-dd HH:mm:ss";
        formatter.timeZone = self.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: self.timeZone * kTTSecondsOneTimeZone);
        
        return formatter.stringFromDate(date);
    }
    
    func deltaTFromZoneTime2Location() -> String {
        let timeZone01 = self.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: self.timeZone * kTTSecondsOneTimeZone);
        let deltaT = Double(timeZone01.secondsFromGMT) - round(self.coordinate.longitude * kTTSecondsOneLongitude);
        let formatter = CLLocation.dateFormatter;
        formatter.dateFormat = deltaT > 0 ? "HH:mm:ss" : "-HH:mm:ss";
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: fabs(deltaT)));
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
        
        let timeZone01 = self.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: self.timeZone * kTTSecondsOneTimeZone);
        let timeZone02 = location.placemarks?.last?.timeZone ?? NSTimeZone(forSecondsFromGMT: location.timeZone * kTTSecondsOneTimeZone);
        deltaDateForTimeZone = timeZone02.secondsFromGMT - timeZone01.secondsFromGMT;
        
        return (deltaDateForTimeZone, deltaDateForAbsolute);
    }
}