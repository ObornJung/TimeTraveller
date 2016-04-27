//
//  TTPOISearchService.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/29/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import ReactiveCocoa

class TTPOISearchService: NSObject, AMapSearchDelegate {
    
    static let sharedInstance = TTPOISearchService();
    
    let poiSearchServer = AMapSearchAPI();
    
    func searchPOI(keywords: String, region: MKCoordinateRegion?) -> RACSignal {
        
        poiSearchServer.delegate = self;
        //
        // 1、构造AMapPOIAroundSearchRequest对象，设置周边请求参数
        let request = AMapPOIPolygonSearchRequest();
        if let searchRegion = region {
            var latitude = CGFloat(searchRegion.center.latitude - searchRegion.span.latitudeDelta * 2);
            var longitude = CGFloat(searchRegion.center.longitude - searchRegion.span.longitudeDelta * 2);
            let leftTop = AMapGeoPoint.locationWithLatitude(latitude, longitude: longitude);
            latitude = CGFloat(searchRegion.center.latitude + searchRegion.span.latitudeDelta * 2);
            longitude = CGFloat(searchRegion.center.longitude + searchRegion.span.longitudeDelta * 2);
            let rightBottom = AMapGeoPoint.locationWithLatitude(latitude, longitude: longitude);
            request.polygon = AMapGeoPolygon(points: [leftTop, rightBottom]);
        }

        /**
        * types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
        * POI的类型共分为20种大类别，分别为：
        * 体育休闲服务|金融保险服务|汽车服务|汽车销售|汽车维修|政府机构及社会团体|
        * 医疗保健服务|科教文化服务|住宿服务|风景名胜|商务住宅|公共设施|摩托车服务|
        * 交通设施服务|道路附属设施|生活服务|购物服务|公司企业|餐饮服务|地名地址信息|
        */
        request.types = "地名地址信息|商务住宅|餐饮服务|生活服务";
        request.sortrule = 1;
        request.keywords = keywords;
        request.requireExtension = true;
        
        let signal = RACSignal.createSignal {[unowned self] (subscriber: RACSubscriber!) -> RACDisposable! in
            let searchProtocol = NSProtocolFromString("AMapSearchDelegate")!;
            let responseSignal = self.rac_signalForSelector(#selector(AMapSearchDelegate.onPOISearchDone(_:response:)), fromProtocol: searchProtocol).map({ (object: AnyObject!) -> AnyObject! in
                return (object as? RACTuple)?.second as? AMapPOISearchResponse;
            });
            let errorSignal = self.rac_signalForSelector(#selector(AMapSearchDelegate.AMapSearchRequest(_:didFailWithError:)), fromProtocol: searchProtocol).map( { (object: AnyObject!) -> AnyObject! in
                return (object as? RACTuple)?.second as? NSError;
            });
            
            responseSignal.subscribeNext({ (object: AnyObject!) -> Void in
                subscriber.sendNext(object);
                subscriber.sendCompleted();
            })
            
            errorSignal.subscribeNext({ (object: AnyObject!) -> Void in
                subscriber.sendError(object as? NSError);
            })
            
            return RACDisposable(block: { () -> Void in
                OBLog("");
            });
        }
        
        //
        // 发起周边搜索
        self.poiSearchServer.AMapPOIPolygonSearch(request);
        
        return signal;
    }
    
    func cancelSearch() -> Void {
        self.poiSearchServer.cancelAllRequests();
    }
}
