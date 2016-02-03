//
//  TTPointAnnotation.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/21/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit

class TTPointAnnotation: MKPointAnnotation {
    
    private(set) var location: CLLocation!;
    private(set) var poi: AMapPOI!;
    
//    override var coordinate: CLLocationCoordinate2D {
//        didSet {
//            let newLocation = CLLocation(coordinate: coordinate);
//            newLocation.placemarks = location.placemarks;
//            newLocation.validPlacemarks = location.validPlacemarks;
//            location = newLocation;
//        }
//    }
    
    init(location: CLLocation) {
        self.location = location;
        super.init();
        self.coordinate = self.location.coordinate;
    }
    
    init(poi: AMapPOI) {
        self.poi = poi;
        super.init();
        self.coordinate = CLLocationCoordinate2DMake(Double(self.poi.location.latitude),
                                                     Double(self.poi.location.longitude));
        self.title = poi.name;
    }
    
}
