//
//  TTPOIModel.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/28/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit

let kTTPOIModelKey = "poiItem"

class TTPOIModel: OBBaseComponentModel {
    
    var name: String?;
    var tzName: String?;
    var address: String?;
    var coordinate: CLLocationCoordinate2D?;
}
