//
//  TTLocationCenter.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/1/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit
import CoreLocation

typealias TTLocationCompletionHandler = (CLLocation?, NSError?) -> Void;

class TTLocationCenter: NSObject, CLLocationManagerDelegate {

    static var multitimeLocation = false;
    private static let sharedInstance = TTLocationCenter();
    
    private var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager();
        locationManager.distanceFilter  = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        return locationManager;
    }()
    
    private var locationcClosure: TTLocationCompletionHandler?;
    
    private override init() {
        super.init();
        self.requestLocationAccess();
    }
    
    private func requestLocationAccess() {
        locationManager.delegate = self;
        if (CLLocationManager.locationServicesEnabled() &&
            CLLocationManager.authorizationStatus() == .NotDetermined) {
                self.locationManager.requestWhenInUseAuthorization();
        }
    }
    
//MARK: - Functions
    class func currentLocation(closure: TTLocationCompletionHandler?) {
        var error: NSError?;
        self.sharedInstance.locationcClosure = closure;
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                self.sharedInstance.locationManager.startUpdatingLocation();
            case .NotDetermined:
                self.sharedInstance.requestLocationAccess();
                OBAlert.alertWithMessage(NSLocalizedString("location_forbid_tips", comment: "无定位权限提示"),
                    buttonTitles: [NSLocalizedString("cancle", comment: "取消")]);
                fallthrough;
            default:
                error = NSError(domain: "", code: Int(CLLocationManager.authorizationStatus().rawValue), userInfo: nil);
                break;
            }
        } else {
            error = NSError(domain: "", code: Int(CLAuthorizationStatus.Denied.rawValue), userInfo: nil);
            OBAlert.alertWithMessage(NSLocalizedString("location_forbid_tips", comment: "无定位权限提示"),
                buttonTitles: [NSLocalizedString("cancle", comment: "取消")]);
        }
        if error != nil {
            closure?(nil, error);
        }
    }

//MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.dynamicType.multitimeLocation {
            manager.stopUpdatingLocation();
        }
        self.locationcClosure?(locations.last, nil);
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if !self.dynamicType.multitimeLocation {
            manager.stopUpdatingLocation();
        }
        self.locationcClosure?(nil, error);
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedAlways ||
            status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            manager.startUpdatingLocation();
        }
    }
}
