//
//  TTDateViewModel.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/2/5.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import MapKit
import ReactiveCocoa

class TTDateViewModel: NSObject {
    
    let dateModel = TTDateModel();
    
    let updateCommand: RACCommand = {
        return RACCommand { (input: AnyObject!) -> RACSignal! in
            return RACSignal.createSignal({ (subscriber: RACSubscriber!) -> RACDisposable! in
                if let location = input as? CLLocation {
                    subscriber.sendNext(location);
                    subscriber.sendCompleted();
                } else {
                    subscriber.sendError(NSError(domain: "input parameter error!", code: 0, userInfo: nil));
                }
                return nil;
            })
        }
    }();
    
}
