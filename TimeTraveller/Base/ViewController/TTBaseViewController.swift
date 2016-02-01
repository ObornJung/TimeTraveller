//
//  TTBaseViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 12/22/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import UIKit

class TTBaseViewController: UIViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return false;
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default;
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown;
    }
    
    func hiddenNavBar(hidden: Bool, animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(hidden, animated: animated);
    }
    
    func hiddenTabBar(hidden: Bool) {
        self.tabBarController?.tabBar.hidden = hidden;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.setupViews();
    }
    
    func setupViews() {}
    
    func pushViewController(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated);
    }
}
