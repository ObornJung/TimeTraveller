//
//  TTAnnotationView.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/21/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 8.0, *)
class TTAnnotationView: MKAnnotationView {
    
    static let identifier = "TTAnnotationView";

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier);
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        self.setupViews();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    private func setupViews() {
        self.image = UIImage(named: "map_poi_0");
        self.backgroundColor = UIColor.clearColor();
    }
}
