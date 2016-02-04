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
class TTAnnotationView: MKAnnotationView {
    
    static let identifier = "TTAnnotationView";
    
    private var detailTitle: String? {
        get {
            return (self.detailCalloutAccessoryView as? UILabel)?.text;
        }
        set {
            if let detailLabel = self.detailCalloutAccessoryView as? UILabel {
                detailLabel.text = newValue;
                detailLabel.snp_remakeConstraints { (make) -> Void in
                    make.size.equalTo(detailLabel.sizeThatFits(CGSize.zero));
                }
                self.detailCalloutAccessoryView = detailLabel;
                self.sizeToFit();
                OBLog(self.ob_recursiveDiscription(), showContext: false);
            }
        }
    }
    
    deinit {
        self.annotation = nil;
    }

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
        self.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure);

        /**
        *    setup detail label
        */
        let detailView = UILabel();
        detailView.numberOfLines = 3;
        detailView.font = TTStyle.font(13);
        detailView.textColor = TT_BlackText_Color;
        detailView.text = "中国时间:2016-02-03 11:07:56 (东八区)\n绝对时间:2016-02-03 11:00:23\n时区偏差:2小时23分32秒";
        detailView.backgroundColor = UIColor.clearColor();
        detailView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(detailView.sizeThatFits(CGSizeZero));
        }
        self.detailCalloutAccessoryView = detailView;
    }
    
    override func prepareForReuse() {
        self.annotation  = nil;
        self.detailTitle = nil;
    }
    
    override func addSubview(view: UIView) {
        super.addSubview(view);
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            OBLog(self.ob_recursiveDiscription(), showContext: false);
            if let titleLabel = self.rightCalloutAccessoryView?.superview?.superview?.superview?.subviews[2] as? UILabel {
                titleLabel.adjustsFontSizeToFitWidth = true;
            }
        }
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let poiAnnotation = self.annotation as? TTPOIAnnotation {
                poiAnnotation.removeObserver(self, forKeyPath: "subtitle");
            }
            self.detailTitle = newValue?.subtitle ?? nil;
        }
        didSet {
            if let poiAnnotation = self.annotation as? TTPOIAnnotation {
                poiAnnotation.addObserver(self, forKeyPath: "subtitle", options: .New, context: nil);
            }
        }
    }
    
    override var detailCalloutAccessoryView: UIView? {
        willSet {
            OBLog(self.ob_recursiveDiscription(), showContext: false);
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "subtitle" {
            self.detailTitle = (object as? TTPOIAnnotation)?.subtitle ?? nil;
        }
    }
}
