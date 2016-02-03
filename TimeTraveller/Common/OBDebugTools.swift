//
//  OBDebugTools.swift
//  OBSuperCalculator
//
//  Created by Oborn.Jung on 12/24/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import Toast
import Foundation

func OBLog(message: String, function: String = __FUNCTION__, line: Int = __LINE__) {
    #if DEBUG
        print("\(function) [Line \(line)] --By ObornJung-- \(message)")
    #endif
}

func OBShowToast(message: String, title: String? = nil, duration: NSTimeInterval = 2.0, position: String = CSToastPositionCenter) {
    if !message.isEmpty {
        struct OBToast {
            static let toastWindow: UIWindow = {
                let _toastWindow = UIWindow(frame: UIScreen.mainScreen().bounds);
                _toastWindow.windowLevel = UIWindowLevelAlert;
                _toastWindow.backgroundColor = UIColor.clearColor();
                return _toastWindow;
            }();
            static weak var preToastView: UIView?;
        }
        CSToastManager.setQueueEnabled(false);
        OBToast.toastWindow.hidden = false;
        let toastView = OBToast.toastWindow.toastViewForMessage(message, title: title, image: nil, style: nil);
        OBToast.toastWindow.showToast(toastView, duration: duration, position: position, completion: { (didTap: Bool) -> Void in
            OBToast.toastWindow.hidden = true;
        })
//        let preToastView = OBToast.preToastView;
//        if preToastView != nil && OBToast.toastWindow.respondsToSelector("cs_hideToast:") {
//            OBToast.toastWindow.performSelector("cs_hideToast:", withObject: preToastView);
//        }
//        OBToast.preToastView = toastView;
    }
}
