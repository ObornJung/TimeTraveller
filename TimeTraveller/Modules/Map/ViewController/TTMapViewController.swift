//
//  TTMapViewController.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/19/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import UIKit
import MapKit

class TTMapViewController: TTBaseViewController, MKMapViewDelegate {
    
    let mapView: MKMapView = {
        let mapView      = MKMapView();
        mapView.mapType  = .Standard;
        return mapView;
    }();
    
    private(set) var currentCoordinate: CLLocationCoordinate2D?;
    
    override func loadView() {
        self.mapView.delegate = self;
        self.view = mapView;
    }
    
    override func setupViews() {
        /**
         *    setup add annotation gesture
         */
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressGesture:");
        self.mapView.addGestureRecognizer(longPressGesture);
        self.mapView.showsUserLocation = true;
        /**
        *    start up location
        */
        self.startupLocation();
    }
    
    func addAnnocationPOI(poi: AMapPOI) {
        let objectAnnotation = TTPOIAnnotation(poi: poi);
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    private func startupLocation() {
        
        TTLocationCenter.currentLocation { (location: CLLocation?, error: NSError?) -> Void in 
            
            if let currentLocation = location {
                self.currentCoordinate = currentLocation.coordinate;
                let currentLocationSpan = MKCoordinateSpanMake(0.03, 0.03)
                let currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate,
                                                                             span: currentLocationSpan)
                self.mapView.setRegion(currentRegion, animated: true);
            }
        }
    }
    
    func longPressGesture(gesture: UIGestureRecognizer) {

        if (gesture.state == .Began) {
            let touchPoint = gesture.locationInView(gesture.view);
            let location = CLLocation(coordinate: self.mapView.convertPoint(touchPoint, toCoordinateFromView: gesture.view));
            let objectAnnotation = TTPOIAnnotation(location: location);
            objectAnnotation.title = "加载中...";
            self.mapView.addAnnotation(objectAnnotation)
            
//            location.updatePlacemarks({[unowned location] (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
//                if (error == nil && placemarks?.count > 0) {
//                    let currentDate = NSDate();
//                    objectAnnotation.title = placemarks?.first?.name ?? "";
//                    let zoneTime = location.locationDateString(currentDate);
//                    objectAnnotation.subtitle = "\(zoneTime)\n绝对时间: \(location.absoluteLocationDateString(currentDate))";
//                    objectAnnotation.subtitle = "中国时间:2016-02-03 11:07:56 (东八区)\n绝对时间:2016-02-03 11:00:23\n时区偏差:2小时23分32秒";
//                    
//                } else {
//                    OBLog("\(error)");
//                }
//            });
        }
    }
    
//    //MARK: - MKMapViewDelegate
//
//    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        print("地图缩放级别发送改变时")
//    }
//    
//    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print("地图缩放完毕触法")
//    }
//    
//    func mapViewWillStartLoadingMap(mapView: MKMapView) {
//        print("开始加载地图")
//    }
//    
//    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
//        print("地图加载结束")
//    }
//    
//    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
//        print("地图加载失败")
//    }
//    
//    func mapViewWillStartRenderingMap(mapView: MKMapView) {
//        print("开始渲染下载的地图块")
//    }
//    
//    func mapViewDidFinishRenderingMap(mapView: MKMapView, fullyRendered: Bool) {
//        print("渲染下载的地图结束时调用")
//    }
//
    func mapViewWillStartLocatingUser(mapView: MKMapView) {
        print("正在跟踪用户的位置")
    }
    
    func mapViewDidStopLocatingUser(mapView: MKMapView) {
        print("停止跟踪用户的位置")
    }

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.currentCoordinate = userLocation.coordinate;
    }
//
//    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError) {
//        print("跟踪用户的位置失败")
//    }
//    
//    func mapView(mapView: MKMapView, didChangeUserTrackingMode mode: MKUserTrackingMode, animated: Bool) {
//        print("改变UserTrackingMode")
//    }
//    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//        print("设置overlay的渲染")
////        return nil
//        var renderer: MKOverlayRenderer?;
//        
//        if (overlay is CrumbPath)
//        {
//            if (self.crumbPathRenderer == nil)
//            {
//                self.crumbPathRenderer = CrumbPathRenderer(overlay: overlay);
//            }
//            renderer = self.crumbPathRenderer;
//        }
//        else if overlay is MKPolygon
//        {
//            if ((self.drawingAreaRenderer?.polygon.isEqual(overlay)) == nil)
//            {
//                self.drawingAreaRenderer = MKPolygonRenderer(overlay: overlay);
//                self.drawingAreaRenderer?.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.25);
//            }
//            renderer = self.drawingAreaRenderer;
//        }
//        
//        return renderer!;
//    }
//
//    func mapView(mapView: MKMapView, didAddOverlayRenderers renderers: [MKOverlayRenderer]) {
//        print("地图上加了overlayRenderers后调用")
//    }
//    
    /*** 下面是大头针标注相关 *****/
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        print("添加注释视图")
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            print("点击注释视图按钮")
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("点击大头针注释视图")
        view.draggable = true;
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        print("取消点击大头针注释视图")
        
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
    
//    -(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
//    {
//    MKOverlayView *view=nil;
//    if ([overlay isKindOfClass:[MKCircle class]]) {
//    MKCircleView *cirView =[[MKCircleView alloc] initWithCircle:overlay];
//    cirView.fillColor=[UIColor redColor];
//    cirView.strokeColor=[UIColor redColor];
//    cirView.alpha=0.1;
//    cirView.lineWidth=4.0;
//    view=[cirView autorelease];
//    
//    }
//    return view;
//    }
}
