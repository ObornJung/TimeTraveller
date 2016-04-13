//
//  TTDateViewModel.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/2/5.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import MapKit
import ReactiveCocoa

final class TTDateViewModel: NSObject {
    
    //MARK: - input
    var coordinate: CLLocationCoordinate2D!
//        {
//        willSet {
//            if coordinate == nil || self.location.coordinate.longitude != newValue.longitude
//                || self.location.coordinate.latitude != self.location.coordinate.latitude {
//                self.location = CLLocation(coordinate: newValue);
//                self.action.apply(true).start();
//            }
//        }
//    }
    
    var updateInterval: NSTimeInterval? {
        willSet {
            if newValue != updateInterval {
                self.updateTimer?.fire();
                self.updateTimer = nil;
            }
            if let interval = newValue {
                self.updateTimer = NSTimer(timeInterval: interval, target: self,
                    selector: "updateTimerHander:", userInfo: nil, repeats: true);
            }
        }
    }
    
    var pulseAction: Action<Int, AnyClass, NSError>?;

    //MARK: - output
    let dateModel: TTDateModel = TTDateModel();

    //MARK: - private property
    private lazy var action: Action<Bool, TTDateModel, NSError> = {
        return Action(){[unowned self] input in
            return SignalProducer(){ observer, disposable in
                
                let updateDateClosure = {
                    let dateOfNow = NSDate();
                    self.dateModel.deltaDate.value = self.location.deltaTFromZoneTime2Location();
                    self.dateModel.localDate.value = self.location.locationDateString(dateOfNow);
                    self.dateModel.zoneDate.value  = self.location.zoneTimeDateString(dateOfNow);
                    observer.sendCompleted();
                }
                
                if input {  ///< 需要更新placemarks
                    CLGeocoder().reverseGeocodeLocation(self.location) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                        if error == nil {
                            self.location.placemarks = placemarks;
                            updateDateClosure();
                        } else {
                            observer.sendFailed(error!);
                        }
                    }
                } else {
                    updateDateClosure();
                }
            };
        }
    }();
    
    private var updateTimer: NSTimer?;
    
    private var location: CLLocation!;
    
    //MARK: - methods
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init();
        self.coordinate = coordinate;
    }
    
    deinit {
        self.updateInterval = nil;
    }
    
    func updateTimerHander(timer: NSTimer) {
        self.action.apply(false).start();
    }
}
