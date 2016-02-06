//
//  TTPOICell.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/28/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit

let kTTUpScreenNotification = "TTUpScreenNotification";

class TTPOICell: OBTableBaseCell {
    
    let poiName     = UILabel();
    let poiDetail   = UILabel();
    
    override static func tableView(tableView: UITableView!, rowHeightForModel model: OBBaseComponentModel!) -> CGFloat {
        return 60.0;
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
    
    override func setupViews() {
        super.setupViews();
        self.contentView.backgroundColor = UIColor.clearColor();
        self.selectionStyle              = .Default;
        /**
        *    setup poi icon
        */
        let poiIcon = UIImageView(image: UIImage(named: "map_search_poi_icon"));
        poiIcon.contentMode = .Center;
        self.contentView.addSubview(poiIcon);
        poiIcon.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.contentView);
            make.leading.equalTo(self.contentView.snp_leading).offset(5);
            make.width.equalTo(20);
        };
        /**
         *    setup upper button
         */
        let upperButton = UIButton(type: .Custom);
        upperButton.imageView?.contentMode = .Center;
        upperButton.setImage(UIImage(named: "map_sug_add_normal"), forState: .Normal);
        upperButton.setImage(UIImage(named: "map_sug_add_highlighted"), forState: .Highlighted);
        self.addSubview(upperButton);
        upperButton.snp_makeConstraints { (make) -> Void in
            make.top.bottom.trailing.equalTo(self.contentView);
            make.width.equalTo(50);
        };
        upperButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext {[unowned self] (button) -> Void in
            var userInfo: [String: String]?;
            if let text = self.poiName.text {
                userInfo = ["word": text]
            }
            NSNotificationCenter.defaultCenter().postNotificationName(kTTUpScreenNotification, object: self, userInfo: userInfo)
        }
        /**
        *    setup poi name
        */
        self.poiName.text = "陆家嘴世纪金融广场";
        self.poiName.font = TTStyle.font(16);
        self.poiName.textColor = TT_BlackText_Color;
        self.contentView.addSubview(self.poiName);
        self.poiName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(10);
            make.leading.equalTo(poiIcon.snp_trailing).offset(5);
            make.trailing.equalTo(upperButton.snp_leading);
        };
        /**
        *    setup poi detail
        */
        self.poiDetail.text = "上海市浦东新区杨高南路759号";
        self.poiDetail.font = TTStyle.font(13);
        self.poiDetail.textColor = TT_GrayText_Color;
        self.contentView.addSubview(self.poiDetail);
        self.poiDetail.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.poiName.snp_bottom).offset(6);
            make.leading.trailing.equalTo(self.poiName);
        };
    }
    
    override func setModel(componentModel: OBBaseComponentModel!) {
        if let poiModel = componentModel as? TTPOIModel {
            self.poiName.text = poiModel.name;
            self.poiDetail.text = poiModel.address;
        }
    }
}
