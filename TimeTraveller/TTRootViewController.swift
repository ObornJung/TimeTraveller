//
//  TTRootViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/15/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class TTRootViewController: TTBaseViewController, UISearchControllerDelegate {
    
    var searchBarController: UISearchController!;
    let mapViewController = TTMapViewController();
    let searchController  = TTPOISearchController();
    let rtDashboardController = TTDateDashboardController();

    var currentLocationViewModel: TTDateViewModel?;

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.hiddenNavBar(hidden:false, animated: animated);
    }
    
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
        self.rtDashboardController.showBorder = true;
        self.rtDashboardController.gaussianBlur = true;
        self.view.addSubview(self.rtDashboardController.view);
        self.addChildViewController(self.rtDashboardController);
        self.rtDashboardController.view.snp_makeConstraints { (make) -> Void in
            make.trailing.bottom.equalTo(self.view).offset(-4);
        }
    }
    
    override func bindViewModel() {

        self.rtDashboardController.viewModel.location <~ self.mapViewController.currentLocation;
//        self.currentLocationViewModel = TTDateViewModel(coordinate: self.mapViewController.currentCoordinate);
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

