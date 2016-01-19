//
//  TTLocationCenter.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit
import ObjectiveC
import ReactiveCocoa

extension CLLocation {
    private struct AssociatedKeys {
        static var timeZoneId = "tt_timeZoneId"
        static var isSync = "tt_isSync"
    }
    
    var timeZoneId: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.timeZoneId) as? String;
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.timeZoneId, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    var isSync: Bool {
        get {
            if let isSync = objc_getAssociatedObject(self, &AssociatedKeys.isSync) as? Bool {
                return isSync;
            }
            return false;
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.isSync, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    var timeZone: Int {
        return lround(self.coordinate.longitude / 15.0);
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
        
        if (self.isSync && location.isSync) {
            var timeZone01: NSTimeZone!;
            if let timeZoneId = self.timeZoneId {
                timeZone01 = NSTimeZone(name:timeZoneId);
            } else {
                timeZone01 = NSTimeZone(forSecondsFromGMT: self.timeZone * kTTSecondsOneTimeZone);
            }
            
            var timeZone02: NSTimeZone!;
            if let timeZoneId = location.timeZoneId {
                timeZone02 = NSTimeZone(name:timeZoneId);
            } else {
                timeZone02 = NSTimeZone(forSecondsFromGMT: location.timeZone * kTTSecondsOneTimeZone);
            }
            deltaDateForTimeZone = timeZone02.secondsFromGMT - timeZone01.secondsFromGMT;
        }
        
        return (deltaDateForTimeZone, deltaDateForAbsolute);
    }
}

//MARK: -

class TTLocationCenter: NSObject, CLLocationManagerDelegate {

    private var locationManager: CLLocationManager!;
    private var locationcClosure: ((_:CLLocation?) -> ())?;
    
    private override init() {
        super.init();
        self.locationManager                 = CLLocationManager();
        self.locationManager.delegate        = self;
        self.locationManager.distanceFilter  = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        if (CLLocationManager.locationServicesEnabled() &&
            CLLocationManager.authorizationStatus() == .NotDetermined) {
            self.locationManager.requestWhenInUseAuthorization();
        }
    }
    
    private class func sharedInstance() -> TTLocationCenter {
        struct _sInstanceFlag {
            static var _sharedInstance: TTLocationCenter!;
            static var onceToken: dispatch_once_t = 0;
        }
        
        dispatch_once(&_sInstanceFlag.onceToken) {
            _sInstanceFlag._sharedInstance = TTLocationCenter();
        };
        return _sInstanceFlag._sharedInstance;
    }
    
    class func currentLocation(closure: ((_:CLLocation?) -> ())?) {
        self.sharedInstance().locationcClosure = closure;
        if (CLLocationManager.authorizationStatus() == .AuthorizedAlways ||
            CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
            self.sharedInstance().locationManager.startUpdatingLocation();
        }
    }

// MARK: – CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation();
        if let closure = self.locationcClosure {
            if let location = locations.last {
                closure(location);
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        manager.stopUpdatingLocation();
        self.locationcClosure?(nil);
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedAlways ||
            status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            manager.startUpdatingLocation();
        }
    }
}
