//
//  TTRootViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/15/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class TTRootViewController: TTBaseViewController {
    
    var testButton: UIButton!;
    lazy var testVar: String! = {return "123"}();

    override func setupViews() {
        self.view.backgroundColor = UIColor.whiteColor();
        self.testButton = UIButton(type: .System);
        self.view.addSubview(self.testButton);
        self.testButton.backgroundColor = UIColor.greenColor();
        self.testButton.setTitle("test", forState: .Normal);
        self.testButton.addTarget(self, action: "testBtnPressed:", forControlEvents: .TouchUpInside);
        self.testButton.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view);
            make.width.equalTo(100);
            make.height.equalTo(50);
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.hiddenNavBar(true);
    }
    
    func testBtnPressed(button: UIButton) {
        let location01 = CLLocation(latitude: 51.28, longitude: 0);
        let location02 = CLLocation(latitude: 40.43, longitude: 116.4);
        TTLocationDateManager.dateOfLocation(location01) { (locationDate: TTLocationDate?) -> () in
 
            OBLog("\(location01.deltaDateToLocation(location02))");
            OBLog("location01:\(locationDate?.locationDate())");
            
        }
        
        TTLocationDateManager.dateOfLocation(location02) { (locationDate: TTLocationDate?) -> () in
            
            OBLog("\(location01.deltaDateToLocation(location02))");
            OBLog("location02:\(locationDate?.locationDate())");
        }
    }
}

