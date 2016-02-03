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
//        self.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure);

        /**
        *    setup detail view
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
}
