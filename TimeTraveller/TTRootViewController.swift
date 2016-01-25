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
        CLLocation.currentLocationDateString(NSDate(), showTZName: true) { (dateString: String?, error: NSError?) -> Void in
            OBLog("\(dateString)")
        }
    }
}

