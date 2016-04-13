//
//  TTDateModel.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/2/5.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import ReactiveCocoa

class TTDateModel: NSObject {
    
    var deltaDate = MutableProperty<String?>("2小时32分钟10秒");
    var localDate = MutableProperty<String?>("2016-02-04 15:06:55");
    var zoneDate  = MutableProperty<String?>("2016-02-04 15:06:55");

}
