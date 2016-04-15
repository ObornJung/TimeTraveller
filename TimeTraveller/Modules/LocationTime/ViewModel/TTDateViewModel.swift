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
    let location = MutableProperty<CLLocation?>(nil);
    
    //MARK: - output
    let dateModel: TTDateModel = TTDateModel();
    private(set) var pulseAction: Action<Int, AnyClass?, NoError>!;
    
    //MARK: - methods
    init(location: CLLocation?) {
        super.init();
        self.location.value = location;
        self.pulseAction = Action() { input in
            return SignalProducer() { observer, disposable in
                disposable.addDisposable(timer(Double(input), onScheduler: QueueScheduler.mainQueueScheduler).take(Int.max).startWithNext({[weak self] date in
                    self?.updateModel(NSDate());
                    }));
                disposable.addDisposable(ActionDisposable() { observer.sendCompleted(); });
            }
        }
        self.updateModel(NSDate());
    }
    
    private func updateModel(date : NSDate) {
        self.dateModel.zoneDate.value  = self.location.value?.zoneTimeDateString(date) ?? "yyyy-MM-dd HH:mm:ss";
        self.dateModel.localDate.value = self.location.value?.locationDateString(date) ?? "yyyy-MM-dd HH:mm:ss";
        self.dateModel.deltaDate.value = self.location.value?.deltaTFromZoneTime2Location() ?? "HH:mm:ss";
    }
}
