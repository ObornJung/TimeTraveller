//
//  TTPointAnnotation.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/21/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit

class TTPOIAnnotation: MKShape {
    
    private(set) var location: CLLocation!;
    private(set) var poi: AMapPOI!;
    
    override var coordinate: CLLocationCoordinate2D {
        if self.location != nil {
            return self.location.coordinate;
        }
        return CLLocationCoordinate2DMake(Double(self.poi.location.latitude), Double(self.poi.location.longitude));
    }
    
    init(location: CLLocation) {
        self.location = location;
        super.init();
    } 
    
    init(poi: AMapPOI) {
        self.poi = poi;
        super.init();
        self.title = poi.name;
    }
}
