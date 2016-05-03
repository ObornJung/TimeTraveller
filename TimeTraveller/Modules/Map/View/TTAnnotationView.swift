//
//  TTAnnotationView.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/21/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit
import ReactiveCocoa

@available(iOS 8.0, *)
class TTAnnotationView: MKAnnotationView, UIGestureRecognizerDelegate {
    
    static let identifier = "TTAnnotationView";
    
    private let dateDashboard = TTDateDashboardController();
    private var dashboardDisposable: Disposable?;

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier);
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        self.setupViews();
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        if selected {
            if !(self.dashboardDisposable?.disposed ?? true) {
                self.dashboardDisposable?.dispose();
            }
            if let poiAnnotation = self.annotation as? TTPOIAnnotation {
                self.dashboardDisposable = self.dateDashboard.viewModel.location <~ poiAnnotation.location;
            }
        } else {
            self.dashboardDisposable?.dispose();
        }
    }
    
    override func addSubview(view: UIView) {
        super.addSubview(view);
        dispatch_async(dispatch_get_main_queue()) {[weak self] in
            guard let rightAccessoryView = self?.rightCalloutAccessoryView?.superview else { return };
            rightAccessoryView.snp_updateConstraints(closure: { (make) in
                make.trailing.equalTo(0);
                make.size.equalTo(CGSizeZero);
            })
            
            guard let titleLabel = self?.detailCalloutAccessoryView?.superview?.subviews[2] as? UILabel else { return; }
            titleLabel.font = TTStyle.boldFontOfSize(14);
            titleLabel.adjustsFontSizeToFitWidth = true;
        };
    }
    
    override func prepareForReuse() {
        self.annotation  = nil;
        if !(self.dashboardDisposable?.disposed ?? true) {
            self.dashboardDisposable?.dispose();
        }
    }

    private func setupViews() {
        
        self.image = UIImage(named: "map_poi_0");
        self.backgroundColor = UIColor.clearColor();

        /**
        *    setup detail label
        */
        self.dateDashboard.showBorder = false;
        self.dateDashboard.gaussianBlur = false;
        self.dateDashboard.view.userInteractionEnabled = false;
        self.detailCalloutAccessoryView = self.dateDashboard.view;
        self.dateDashboard.view.backgroundColor = UIColor.clearColor();
        self.dateDashboard.updateEdgeInsets(UIEdgeInsetsMake(-15, -3, 10, 10));
        self.rightCalloutAccessoryView = UIButton(type: .InfoDark);
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        var hitFrame = self.bounds;
        if !self.hidden {
            hitFrame = UIEdgeInsetsInsetRect(hitFrame, UIEdgeInsetsMake(-5, -5, -5, -5));
        }
        return CGRectContainsPoint(hitFrame, point);
    }
}
