//
//  TTRootViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/15/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import SnapKit

class TTRootViewController: TTBaseViewController {
    
    var testButton: UIButton!;
    
    lazy var mapViewController: TTMapViewController = {
        let mapViewController = TTMapViewController();
        self.addChildViewController(mapViewController);
        self.view.addSubview(mapViewController.view);
        return mapViewController;
    }();

    override func setupViews() {

        self.mapViewController.view .snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view);
        }
        
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
        let location01 = CLLocation(latitude: 51.28, longitude: 121);
        let location02 = CLLocation(latitude: 40.43, longitude: 120);
        
        OBLog("location01:\(location01.absoluteLocationDateString())");
        OBLog("location02:\(location02.absoluteLocationDateString())");
        CLLocation.currentAbsoluteLocationDateString { (dateString: String?, error: NSError?) -> Void in
            OBLog("current location absolute time:\(dateString)");
        }
//        location01.locationDateString { (dateString: String?, error: NSError?) -> Void in
//            OBLog("\(location01.deltaDateToLocation(location02))");
//            OBLog("location01:\(dateString)");
//        }
    }
}

