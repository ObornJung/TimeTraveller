//
//  TTDateDashboard.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 2/4/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

class TTDateDashboard: TTBaseView {
    
    let addrName  = UILabel();
    let zoneTime  = UILabel();
    let localTime = UILabel();
    let deltaTime = UILabel();
    
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
        
//        self.addrName.numberOfLines = 2;
//        self.addrName.font = TTStyle.font(10);
//        self.addrName.textColor = TT_BlackText_Color;
//        self.addrName.adjustsFontSizeToFitWidth = true;
//        self.addrName.text = "陆家嘴世纪金融广场";
//        self.addSubview(self.addrName);
//        self.addrName.snp_makeConstraints { (make) -> Void in
//            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
//            make.top.leading.equalTo(self).offset(self.layer.cornerRadius);
//            make.height.equalTo(self.addrName.sizeThatFits(CGSizeZero).height*2);
//        }
        
        self.zoneTime.font = TTStyle.font(10);
        self.zoneTime.textColor = TT_BlackText_Color;
        self.zoneTime.adjustsFontSizeToFitWidth = true;
        self.zoneTime.text = "中国时间: 2016-02-04 15:06:55";
        self.addSubview(self.zoneTime);
        self.zoneTime.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
            make.top.leading.equalTo(self).offset(self.layer.cornerRadius);
        }
        
        self.localTime.font = self.zoneTime.font;
        self.localTime.textColor = self.zoneTime.textColor;
        self.localTime.adjustsFontSizeToFitWidth = true;
        self.localTime.text = "绝对时间: 2016-02-04 15:06:55";
        self.addSubview(self.localTime);
        self.localTime.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.zoneTime.snp_bottom);
            make.leading.equalTo(self).offset(self.layer.cornerRadius);
            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
        }
        
        self.deltaTime.font = self.zoneTime.font;
        self.deltaTime.textColor = self.zoneTime.textColor;
        self.deltaTime.adjustsFontSizeToFitWidth = true;
        self.deltaTime.text = "标准时差: 2小时32分钟10秒";
        self.addSubview(self.deltaTime);
        self.deltaTime.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.localTime.snp_bottom);
            make.leading.equalTo(self).offset(self.layer.cornerRadius);
            make.trailing.equalTo(self).offset(-self.layer.cornerRadius);
            make.bottom.equalTo(self.snp_bottom).offset(-self.layer.cornerRadius);
        }
    }
}
