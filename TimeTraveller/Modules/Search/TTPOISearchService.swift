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
        * 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
        * 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
        * 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
        */
        request.types = "地名地址信息|商务住宅|餐饮服务|生活服务";
        request.sortrule = 1;
        request.keywords = keywords;
        request.requireExtension = true;
        
        let searchProtocol = NSProtocolFromString("AMapSearchDelegate")!;
        let signal = self.rac_signalForSelector("onPOISearchDone:response:", fromProtocol: searchProtocol).map({ (object: AnyObject!) -> AnyObject! in
            return (object as? RACTuple)?.second as? AMapPOISearchResponse;
        });
        
        //
        // 发起周边搜索
        self.poiSearchServer.AMapPOIPolygonSearch(request);
        
        return signal;
    }
}
