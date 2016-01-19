//
//  TTBaseNavigationController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 12/22/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import UIKit

class TTBaseNavigationController: UINavigationController {
    
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if let topViewController = self.topViewController {
            return topViewController.preferredStatusBarStyle();
        }
        return UIStatusBarStyle.LightContent;
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown;
    }
    
}
