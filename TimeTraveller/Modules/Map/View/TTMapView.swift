//
//  TTMapView.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/4/25.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit
import ReactiveCocoa

class TTMapView: MKMapView {
    
    private let menuItems: [UIMenuItem] = {
        let delMenuItem = UIMenuItem(title: "删除", action: #selector(TTMapView.delMenuHander(_:)));
        return [delMenuItem];
    }();
    
    private var actionAnnocation: MKAnnotation?;
    
    //MARK: - Menu function
    override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return self.respondsToSelector(action);
    }
    
    func dissmissMenu() {
        if UIMenuController.sharedMenuController().menuVisible {
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true);
        }
    }
    
    //MARK: - Menu action hander
    func delMenuHander(menuItem: UIMenuItem) {
        if let annocation = actionAnnocation {
            self.removeAnnotation(annocation);
        }
    }
    
    //MARK: - Override private methods
    func handleLongPress(gesture: UIGestureRecognizer) {
        if gesture.state == .Began {
            var menuAnchor: CGPoint!;
            let visibleAnnotation = self.annotationsInMapRect(self.visibleMapRect);
            for object in visibleAnnotation {
                guard let annotation = object as? MKAnnotation else { continue; }
                guard let annotationView = self.viewForAnnotation(annotation) else { continue; }
                if CGRectContainsPoint(annotationView.frame, gesture.locationInView(self)) {
                    menuAnchor = CGPointMake(CGRectGetMidX(annotationView.frame),
                                             CGRectGetMinY(annotationView.frame));
                    self.actionAnnocation = annotation;
                    break;
                }
            }
            guard menuAnchor != nil else { return; }
            
            for selAnnotation in self.selectedAnnotations {
                self.deselectAnnotation(selAnnotation, animated: true);
            }
            
            self.becomeFirstResponder();
            let menuFrame = CGRectMake(menuAnchor.x, menuAnchor.y, 0, 0);
            UIMenuController.sharedMenuController().menuItems = self.menuItems;
            UIMenuController.sharedMenuController().setTargetRect(menuFrame, inView: self);
            UIMenuController.sharedMenuController().setMenuVisible(true, animated: true);
        }
    }
    
    func _handleTapToSelect(gesture: UIGestureRecognizer) {
        self.dissmissMenu();
        let visibleAnnotation = self.annotationsInMapRect(self.visibleMapRect);
        for object in visibleAnnotation {
            guard let annotation = object as? MKAnnotation else { continue; }
            guard let annotationView = self.viewForAnnotation(annotation) else { continue; }
            if CGRectContainsPoint(annotationView.frame, gesture.locationInView(self)) {
                self.selectAnnotation(annotation, animated: true);
                break;
            }
        }
    }
    
    func _handleTapToDeselect(gesture: UIGestureRecognizer) {
        self.dissmissMenu();
        for selAnnotation in self.selectedAnnotations {
            self.deselectAnnotation(selAnnotation, animated: true);
        }
    }
    
}
