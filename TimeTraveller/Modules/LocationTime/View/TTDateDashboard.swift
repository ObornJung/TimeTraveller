//
//  TTDateDashboard.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 2/4/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import ReactiveCocoa

class TTDateDashboard: TTBaseView {
    
    let zoneTime  = MutableProperty<String?>("");
    let localTime = MutableProperty<String?>("");
    let deltaTime = MutableProperty<String?>("");
    
    //MARK: - Private property
    private let addrNameLabel  = UILabel();
    private let zoneTimeLabel  = UILabel();
    private let localTimeLabel = UILabel();
    private let deltaTimeLabel = UILabel();
    
    override func setupViews() {
        super.setupViews();
        self.backgroundColor = UIColor.clearColor();
        self.layer.cornerRadius  = 3;
        self.layer.shadowRadius  = 3;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(3, 3);
        self.layer.shadowColor  = UIColor.grayColor().CGColor;
        self.layer.borderWidth  = 0.5;
        self.layer.borderColor  = UIColor(white: 0, alpha: 0.1).CGColor;
        /**
         *    setup blur background view
         */
        let blurEffect = UIBlurEffect(style: .ExtraLight);
        let blurBgView = UIVisualEffectView(effect: blurEffect);
        blurBgView.layer.cornerRadius = 3;
        blurBgView.layer.masksToBounds = true;
        self.addSubview(blurBgView);
        blurBgView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self);
        }
        /**
        *    setup zone time label
        */
        self.zoneTimeLabel.textAlignment = .Left;
        self.zoneTimeLabel.font = TTStyle.font(10);
        self.zoneTimeLabel.textColor = TT_BlackText_Color;
        self.zoneTimeLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.zoneTimeLabel);
        self.zoneTimeLabel.snp_makeConstraints { (make) -> Void in
            make.top.leading.equalTo(self.layer.cornerRadius);
            make.trailing.lessThanOrEqualTo(-self.layer.cornerRadius);
        }
        self.zoneTime.producer.startWithNext({ [weak self] (text) -> () in
            let labelTitle = NSLocalizedString("dashboard_zone_label", comment: "zone time label");
            self?.zoneTimeLabel.text = labelTitle + (text ?? "");
            });
        /**
        *    setup local time label
        */
        self.localTimeLabel.font = self.zoneTimeLabel.font;
        self.localTimeLabel.textColor = self.zoneTimeLabel.textColor;
        self.localTimeLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.localTimeLabel);
        self.localTimeLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.zoneTimeLabel.snp_bottom);
            make.leading.equalTo(self.zoneTimeLabel);
            make.trailing.lessThanOrEqualTo(-self.layer.cornerRadius);
        }
        self.localTime.producer.startWithNext { [weak self] (text) -> () in
            let labelTitle = NSLocalizedString("dashboard_absolute_label", comment: "local time label");
            self?.localTimeLabel.text = labelTitle + (text ?? "");
        }
        /**
        *    setup delta time label
        */
        self.deltaTimeLabel.font = self.zoneTimeLabel.font;
        self.deltaTimeLabel.textColor = self.zoneTimeLabel.textColor;
        self.deltaTimeLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.deltaTimeLabel);
        self.deltaTimeLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.localTimeLabel.snp_bottom);
            make.leading.equalTo(self.zoneTimeLabel);
            make.trailing.lessThanOrEqualTo(-self.layer.cornerRadius);
            make.bottom.equalTo(self.snp_bottom).offset(-self.layer.cornerRadius);
        }
        self.deltaTime.producer.startWithNext { [weak self] (text) -> () in
            let labelTitle = NSLocalizedString("dashboard_delta_label", comment: "delta time label");
            self?.deltaTimeLabel.text = labelTitle + (text ?? "");
        }
    }
}
