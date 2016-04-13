//
//  TTDateDashboardController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/4/7.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TTDateDashboardController: TTBaseViewController {
    
    let viewModel = TTDateViewModel();
    
    //MARK: - Private property
    private var dashboard = TTDateDashboard();
    private var pulseDisposable : Disposable?;
    
    //MARK: - 
    override func loadView() {
        self.view = self.dashboard;
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.startPulse();
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        self.stopPulse();
    }
    
    override func bindViewModel() {
        super.bindViewModel();
        self.dashboard.zoneTime  <~ self.viewModel.dateModel.zoneDate;
        self.dashboard.localTime <~ self.viewModel.dateModel.localDate;
        self.dashboard.deltaTime <~ self.viewModel.dateModel.deltaDate;
    }
    
    //MARK: - Private methods
    
    private func startPulse() {
        self.pulseDisposable = self.viewModel.pulseAction?.apply(1).start();
    }
    
    private func stopPulse() {
        self.pulseDisposable?.dispose();
    }
    
}
