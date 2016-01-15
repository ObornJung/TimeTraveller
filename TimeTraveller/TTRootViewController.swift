//
//  TTRootViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/15/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit

class TTRootViewController: TTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.hiddenNavBar(true);
    }
}

