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
    
    let viewModel = TTDateViewModel(location: nil);
    private(set) var tapSignal: SignalProducer<AnyObject?, NSError>!;
    
    private let disposable = CompositeDisposable();
    var gaussianBlur = false {
        didSet {
            if gaussianBlur {
                if self.blurBgView != nil {return;}
                let blurEffect = UIBlurEffect(style: .ExtraLight);
                self.blurBgView = UIVisualEffectView(effect: blurEffect);
                self.blurBgView?.layer.cornerRadius = 3;
                self.blurBgView?.layer.masksToBounds = true;
                self.view.insertSubview(self.blurBgView!, atIndex: 0);
                self.blurBgView?.snp_makeConstraints { (make) -> Void in
                    make.edges.equalTo(self.view);
                }
            } else {
                self.blurBgView?.removeFromSuperview();
                self.blurBgView = nil;
            }
        }
    }
    var showBorder = false {
        didSet {
            if showBorder {
                self.view.layer.cornerRadius  = 3;
                self.view.layer.shadowRadius  = 3;
                self.view.layer.shadowOpacity = 0.5;
                self.view.layer.shadowOffset = CGSizeMake(3, 3);
                self.view.layer.shadowColor  = UIColor.grayColor().CGColor;
                self.view.layer.borderWidth  = 0.5;
                self.view.layer.borderColor  = UIColor(white: 0, alpha: 0.1).CGColor;
                
            } else {
                self.view.layer.cornerRadius  = 0;
                self.view.layer.shadowRadius  = 0;
                self.view.layer.shadowOpacity = 0;
                self.view.layer.shadowOffset = CGSizeZero;
                self.view.layer.shadowColor  = UIColor.clearColor().CGColor;
                self.view.layer.borderWidth  = 0;
                self.view.layer.borderColor  = UIColor.clearColor().CGColor;
            }
        }
    }
    
    //MARK: - Private property
    private var dashboard = TTDateDashboard();
    private var pulseDisposable : Disposable?;
    private var blurBgView: UIVisualEffectView?;
    
    //MARK: - 
    deinit {
        self.disposable.dispose();
    }
    
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
    
    override func setupViews() {
        super.setupViews();
        let tapGesture = UITapGestureRecognizer();
        self.view.addGestureRecognizer(tapGesture);
        self.tapSignal = tapGesture.rac_gestureSignal().toSignalProducer();
    }

    override func bindViewModel() {
        super.bindViewModel();
        self.disposable.addDisposable(self.dashboard.zoneTime  <~ self.viewModel.dateModel.zoneDate);
        self.disposable.addDisposable(self.dashboard.localTime <~ self.viewModel.dateModel.localDate);
        self.disposable.addDisposable(self.dashboard.deltaTime <~ self.viewModel.dateModel.deltaDate);
    }
    
    func updateEdgeInsets(edgeInsets: UIEdgeInsets) {
        self.dashboard.updateEdgeInsets(edgeInsets);
    }
    
    //MARK: - Private methods
    
    private func startPulse() {
        self.pulseDisposable = self.viewModel.pulseAction.apply(1).start();
    }
    
    private func stopPulse() {
        self.pulseDisposable?.dispose();
    }
    
}
