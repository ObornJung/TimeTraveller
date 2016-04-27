//
//  TTPointAnnotation.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/21/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit
import ReactiveCocoa

class TTPOIAnnotation: MKShape {
    
    let location = MutableProperty<CLLocation?>(nil);
    private(set) var poi: AMapPOI?;
    
    override var coordinate: CLLocationCoordinate2D {
        if self.location.value != nil {
            return self.location.value!.coordinate;
        }
        return CLLocationCoordinate2DMake(self.location.value!.coordinate.latitude,
            self.location.value!.coordinate.longitude);
    }
    
    init(location: CLLocation) {
        self.location.value = location;
        super.init();
    } 
    
    init(poi: AMapPOI) {
        self.poi = poi;
        self.location.value = CLLocation(latitude: Double(poi.location.latitude),
            longitude: Double(poi.location.longitude));
        super.init();
        self.title = poi.name;
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let otherObject = object as? TTPOIAnnotation else { return false; }
        return (self.coordinate.latitude == otherObject.coordinate.latitude &&
                self.coordinate.longitude == otherObject.coordinate.longitude);
    }
}
