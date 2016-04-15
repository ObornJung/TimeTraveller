//
//  TTDateModel.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/2/5.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import ReactiveCocoa

class TTDateModel: NSObject {

    var zoneDate  = MutableProperty<String?>("yyyy-MM-dd HH:mm:ss");
    var localDate = MutableProperty<String?>("yyyy-MM-dd HH:mm:ss");
    var deltaDate = MutableProperty<String?>("HH:mm:ss");

}
