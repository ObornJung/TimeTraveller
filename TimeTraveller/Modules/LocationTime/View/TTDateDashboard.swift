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

        /**
        *    setup zone time label
        */
        self.zoneTimeLabel.textAlignment = .Left;
        self.zoneTimeLabel.font = TTStyle.font(10);
        self.zoneTimeLabel.textColor = TT_BlackText_Color;
        self.zoneTimeLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.zoneTimeLabel);
        self.zoneTimeLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(3);
            make.top.greaterThanOrEqualTo(3);
            make.trailing.lessThanOrEqualTo(-3);
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
            make.trailing.lessThanOrEqualTo(-3);
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
            make.trailing.lessThanOrEqualTo(-65);
            make.bottom.equalTo(self.snp_bottom).offset(-3);
        }
        self.deltaTime.producer.startWithNext { [weak self] (text) -> () in
            let labelTitle = NSLocalizedString("dashboard_delta_label", comment: "delta time label");
            self?.deltaTimeLabel.text = labelTitle + (text ?? "");
        }
    }
    
    func updateEdgeInsets(edgeInsets: UIEdgeInsets) {
        self.zoneTimeLabel.snp_removeConstraints()
        self.zoneTimeLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(edgeInsets.left + 3);
            make.top.greaterThanOrEqualTo(edgeInsets.top + 3);
            make.trailing.lessThanOrEqualTo(edgeInsets.right - 3);
        }
        self.localTimeLabel.snp_removeConstraints();
        self.localTimeLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.zoneTimeLabel.snp_bottom);
            make.leading.equalTo(self.zoneTimeLabel);
            make.trailing.lessThanOrEqualTo(edgeInsets.right - 3);
        }
        self.deltaTimeLabel.snp_removeConstraints();
        self.deltaTimeLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.localTimeLabel.snp_bottom);
            make.leading.equalTo(self.zoneTimeLabel);
            make.trailing.lessThanOrEqualTo(edgeInsets.right - 65);
            make.bottom.equalTo(self.snp_bottom).offset(edgeInsets.bottom - 3);
        }
    }
}
