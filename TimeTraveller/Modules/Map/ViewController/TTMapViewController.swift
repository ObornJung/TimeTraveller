//
//  TTMapViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/19/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit
import OBUIKit
import ReactiveCocoa

class TTMapViewController: TTBaseViewController, MKMapViewDelegate {
    
    let mapView: MKMapView = {
        let mapView      = MKMapView();
        mapView.mapType  = .Standard;
        return mapView;
    }();
    
    let currentLocation = MutableProperty<CLLocation?>(nil);
    
    //MARK: - Private property
    private let currentLocationBtn = UIButton(type: .Custom);
    
    override func loadView() {
        self.mapView.delegate = self;
        self.view = mapView;
    }
    
    override func setupViews() {
        /**
         *    setup add annotation gesture
         */
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressGesture:");
        self.mapView.showsUserLocation = true;
        self.mapView.addGestureRecognizer(longPressGesture);
        /**
        *    setup current location button
        */
        self.view.addSubview(self.currentLocationBtn);
        
        self.currentLocationBtn.layer.cornerRadius = 3;
        self.currentLocationBtn.layer.masksToBounds = true;
        self.currentLocationBtn.setImage(UIImage(named: "map_location_icon"), forState: .Normal);
        let bgImage = UIImage.ob_imageWithColor(UIColor(white: 0.9, alpha: 1.0), size: CGSizeMake(35, 35));
        self.currentLocationBtn.setBackgroundImage(bgImage, forState: .Normal);
        self.currentLocationBtn.rac_signalForControlEvents(.TouchUpInside).subscribeNext { button in
            self.startupLocation();
        };
        self.currentLocationBtn.snp_updateConstraints { make in
            make.leading.equalTo(16);
            make.bottom.equalTo(-8);
        }
        /**
        *    start up location
        */
        self.startupLocation();
    }
    
    func addAnnocationPOI(poi: AMapPOI) {
        let objectAnnotation = TTPOIAnnotation(poi: poi);
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    func longPressGesture(gesture: UIGestureRecognizer) {

        if (gesture.state == .Began) {
            let touchPoint = gesture.locationInView(gesture.view);
            let location = CLLocation(coordinate: self.mapView.convertPoint(touchPoint, toCoordinateFromView: gesture.view));
            let objectAnnotation = TTPOIAnnotation(location: location);
            objectAnnotation.title = "加载中...";
            self.mapView.addAnnotation(objectAnnotation)
            objectAnnotation.location.value?.updatePlacemarks({ placemarks, error in
                if (error == nil && placemarks?.count > 0) {
                    objectAnnotation.title = placemarks?.first?.locality ?? "";
                    objectAnnotation.subtitle = placemarks?.first?.subLocality ?? "";
                } else {
                    OBLog("\(error)");
                }
            });
        }
    }

    //MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.updateCurrentLocation(userLocation.location);
    }
 
    /*** 下面是大头针标注相关 *****/
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        print("添加注释视图")
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            print("点击注释视图按钮")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState,
        fromOldState oldState: MKAnnotationViewDragState) {
            print("移动annotation位置时调用\(newState.rawValue)")
            switch newState {
            case .Starting:
                break;
            case .Dragging:
                break;
            default:
                view.draggable = false;
                break;
            }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is TTPOIAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(TTAnnotationView.identifier) ??
                TTAnnotationView(annotation: annotation, reuseIdentifier: TTAnnotationView.identifier);
            annotationView.draggable = false;
            annotationView.canShowCallout = true;
            annotationView.annotation = annotation;
            return annotationView;
        }
        return nil;
    }
    
    //MARK: - Private methods
    
    private func startupLocation() {
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in
            self.updateCurrentLocation(location);
            if let curentLocation = location {
                let currentLocationSpan = MKCoordinateSpanMake(0.03, 0.03)
                let currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: curentLocation.coordinate,
                    span: currentLocationSpan)
                self.mapView.setRegion(currentRegion, animated: true);
            }
        }
    }
    
    private func updateCurrentLocation(newlocation: CLLocation?) {
        if let location = newlocation {
            if location.isSameZoneTime(self.currentLocation.value) {
                location.placemarks = self.currentLocation.value!.placemarks;
            }
            self.currentLocation.value = location;
            if let placemarkLocation = location.placemarks?[0].location {
                if placemarkLocation.distanceFromLocation(location) < 100 {
                    return;
                }
            }
            location.updatePlacemarks(nil);
        }
    }
    
}
