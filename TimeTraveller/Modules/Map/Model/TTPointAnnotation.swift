//
//  TTPointAnnotation.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/21/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import MapKit

class TTPointAnnotation: MKPointAnnotation {
    
    private(set) var location: CLLocation;
    
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
    
}
