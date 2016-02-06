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
    
    let rteDashboard = TTDateDashboard();
    let mapViewController = TTMapViewController();
    var searchBarController: UISearchController!;
    let searchController  = TTPOISearchController();

    let testViewModel = TTDateViewModel();
    
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
        self.searchBarController.searchBar.delegate       = self.searchController;
        self.searchBarController.searchBar.placeholder    = NSLocalizedString("location_search", comment: "search placeholder");
        self.definesPresentationContext = true;
        self.navigationItem.titleView   = self.searchBarController.searchBar;
        
        /**
        *    setup current evn dashboard
        */
        self.view.addSubview(self.rteDashboard);
        self.rteDashboard.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(160, 50));
//            make.size.equalTo(self.rteDashboard.sizeThatFits(CGSizeZero));
            make.trailing.bottom.equalTo(self.view).offset(-4);
        }
        
//        self.testViewModel.updateCommand.execute(12).subscribeNext { (object: AnyObject!) -> Void in
//            OBLog("\(object)");
//        };
        self.testViewModel.updateCommand.execute("test").subscribeNext({ (object: AnyObject!) -> Void in
            OBLog("\(object)");
            }) { (error: NSError!) -> Void in
                OBLog("\(error)");
        }
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
        self.searchController.searchRegion = self.mapViewController.mapView.region;
    }
    
    func willDismissSearchController(searchController: UISearchController) {
//        if let annocationPOI = self.searchController.selectedPoi {
//            self.mapViewController.addAnnocationPOI(annocationPOI);
//            let centerCoordinate = CLLocationCoordinate2D(latitude: Double(annocationPOI.location.latitude),
//                longitude: Double(annocationPOI.location.longitude));
//            self.mapViewController.mapView.setCenterCoordinate(centerCoordinate, animated: true);
//        }
    }
}

