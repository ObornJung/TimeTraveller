//
//  OBDebugTools.swift
//  OBSuperCalculator
//
//  Created by Oborn.Jung on 12/24/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import Toast
import Foundation

func OBLog(message: String, showContext: Bool = true, function: String = #function, line: Int = #line) {
    #if DEBUG
        if showContext {
            print("\(function) [Line \(line)] --By ObornJung-- \(message)");
        } else {
            print("\(message)");
        }
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
        /**
        *    hidden previous toast view
        */
        if let preToastView = (OBToast.toastWindow.respondsToSelector("cs_hideToast:") ? OBToast.preToastView : nil) {
            OBToast.toastWindow.performSelector("cs_hideToast:", withObject: preToastView);
        }
        /**
        *    show toast view
        */
        CSToastManager.setQueueEnabled(false);
        OBToast.toastWindow.hidden = false;
        let toastStyle = CSToastStyle(defaultStyle: ());
        toastStyle.messageAlignment = .Center;
        let toastView = OBToast.toastWindow.toastViewForMessage(message, title: title, image: nil, style: toastStyle);
        OBToast.toastWindow.showToast(toastView, duration: duration, position: position, completion: {[weak toastView] (didTap: Bool) -> Void in
            if toastView == OBToast.preToastView {
                OBToast.toastWindow.hidden = true;
            }
        })
        OBToast.preToastView = toastView;
    }
}
