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
    private let addrNameLable  = UILabel();
    private let zoneTimeLable  = UILabel();
    private let localTimeLable = UILabel();
    private let deltaTimeLable = UILabel();
    
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
        self.zoneTimeLable.textAlignment = .Left;
        self.zoneTimeLable.font = TTStyle.font(10);
        self.zoneTimeLable.textColor = TT_BlackText_Color;
        self.zoneTimeLable.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.zoneTimeLable);
        self.zoneTimeLable.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
            make.top.leading.equalTo(self).offset(self.layer.cornerRadius);
        }
        self.zoneTime.producer.startWithNext({ [weak self] (text) -> () in
            self?.zoneTimeLable.text = "官方时间: \(text ?? "")";
        });
        /**
        *    setup local time label
        */
        self.localTimeLable.font = self.zoneTimeLable.font;
        self.localTimeLable.textColor = self.zoneTimeLable.textColor;
        self.localTimeLable.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.localTimeLable);
        self.localTimeLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.zoneTimeLable.snp_bottom);
            make.leading.equalTo(self).offset(self.layer.cornerRadius);
            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
        }
        self.localTime.producer.startWithNext { [weak self] (text) -> () in
            self?.localTimeLable.text = "绝对时间: \(text ?? "")";
        }
        /**
        *    setup delta time label
        */
        self.deltaTimeLable.font = self.zoneTimeLable.font;
        self.deltaTimeLable.textColor = self.zoneTimeLable.textColor;
        self.deltaTimeLable.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.deltaTimeLable);
        self.deltaTimeLable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.localTimeLable.snp_bottom);
            make.leading.equalTo(self).offset(self.layer.cornerRadius);
            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
            make.bottom.equalTo(self.snp_bottom).offset(-self.layer.cornerRadius);
        }
        self.deltaTime.producer.startWithNext { [weak self] (text) -> () in
            self?.deltaTimeLable.text = "标准时差: \(text ?? "")";
        }
    }
}
