//
//  TTAppStateManager.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 12/24/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import Foundation

class TTAppStateManager: NSObject {
    
    class func sharedInstance() -> TTAppStateManager {
        struct _sInstanceFlag {
            static var _sharedInstance: TTAppStateManager!;
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&_sInstanceFlag.onceToken) {
            _sInstanceFlag._sharedInstance = TTAppStateManager();
        };
        return _sInstanceFlag._sharedInstance;
    }
}
