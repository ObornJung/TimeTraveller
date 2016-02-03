//
//  TTRootViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/15/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import SnapKit

class TTRootViewController: TTBaseViewController, UISearchControllerDelegate {
    
    let searchController  = TTPOISearchController();
    var searchBarController: UISearchController!;
    let mapViewController = TTMapViewController();
    
    override func setupViews() {
        
        /**
        *    setup map view
        */
        self.addChildViewController(self.mapViewController);
        self.view.addSubview(self.mapViewController.view);
        self.mapViewController.view .snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view);
        }
        
        /**
        *    setup search controller
        */
        self.searchBarController = UISearchController(searchResultsController: self.searchController);
        self.searchBarController.delegate = self;
        self.searchBarController.dimsBackgroundDuringPresentation = false;
        self.searchBarController.hidesNavigationBarDuringPresentation = false;
        self.searchBarController.searchResultsUpdater = self.searchController;
        self.searchBarController.searchBar.searchBarStyle = .Minimal;
        self.searchBarController.searchBar.placeholder    = NSLocalizedString("location_search", comment: "搜索");
        self.definesPresentationContext = true;
        self.navigationItem.titleView   = self.searchBarController.searchBar;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.hiddenNavBar(false, animated: animated);
    }

    //MARK: - UISearchControllerDelegate
    func willPresentSearchController(searchController: UISearchController) {
        OBLog("\(self.mapViewController.region)");
        self.searchController.searchRegion = self.mapViewController.region;
    }
    
    func willDismissSearchController(searchController: UISearchController) {
        if let annocationPOI = self.searchController.selectedPoi {
            self.mapViewController.addAnnocationPOI(annocationPOI);
        }
    }
}

