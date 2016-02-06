//
//  TTPOIViewModel.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 16/2/5.
//  Copyright © 2016年 Oborn.Jung. All rights reserved.
//

import OBUIKit
import ReactiveCocoa

class TTPOISearchParams {
    var searchKeywords: String;
    var searchRegion: MKCoordinateRegion;
    
    init(searchKeywords: String, searchRegion: MKCoordinateRegion) {
        self.searchKeywords = searchKeywords;
        self.searchRegion = searchRegion;
    }
}

class TTPOIViewModel: OBBaseTableDataSource {
    
    private(set) lazy var updateSugCommand: RACCommand = {
        return RACCommand { (input: AnyObject!) -> RACSignal! in
            return RACSignal.createSignal({ (subscriber: RACSubscriber!) -> RACDisposable! in
                if let searchParams = input as? TTPOISearchParams {
                    TTPOISearchService.sharedInstance.cancelSearch();
                    TTPOISearchService.sharedInstance.searchPOI(searchParams.searchKeywords, region: searchParams.searchRegion).subscribeNext({ (object: AnyObject!) -> Void in
                        self.setDataSource(self.parseData(object));
                        subscriber.sendNext(true);
                        subscriber.sendCompleted();
                        }) { (error: NSError!) -> Void in
                            subscriber.sendError(error);
                    }
                } else {
                    subscriber.sendError(NSError(domain: "input parameter is invalid!",
                        code: AMapSearchErrorCode.InvalidParams.rawValue, userInfo: nil));
                }
                return RACDisposable(block: { () -> Void in
                    OBLog("");
                });
            })
        }
    }();
    
    override func setDataSource(dataSource: [[OBBaseComponentModel]]?) {
        var regularDataSource: [[OBBaseComponentModel]]?;
        if let oriDataSource = dataSource {
            regularDataSource = [[OBBaseComponentModel]]();
            for sectionData in oriDataSource {
                var regularSectionData = [OBBaseComponentModel]();
                for component in sectionData {
                    regularSectionData.append(component);
                    let separator = OBSeparatorModel(separatorStyle: .Line);
                    separator.lineColor = TT_Separator_Color;
                    separator.insets = UIEdgeInsetsMake(0, 30, 0, 0);
                    regularSectionData.append(separator);
                }
                let separator = regularSectionData.last as? OBSeparatorModel;
                separator?.insets = UIEdgeInsetsZero;
                regularDataSource?.append(regularSectionData);
            }
        }
        super.setDataSource(regularDataSource);
    }
    
    private func parseData(data: AnyObject?) -> [[OBBaseComponentModel]]? {
        
        if let response = data as? AMapPOISearchResponse {
            var poisDataSource = [OBBaseComponentModel]();
            for poi in response.pois {
                let poiModel = TTPOIModel();
                poiModel.tag = kTTPOIModelKey;
                poiModel.name = poi.name;
                poiModel.address = poi.province == poi.city ? poi.city: poi.province + poi.city;
                poiModel.address = (poiModel.address ?? "") + (poi.district ?? "") + (poi.address ?? "");
                poisDataSource.append(poiModel);
            }
            if poisDataSource.count > 0 {
                return [poisDataSource];
            }
        }
        return nil;
    }
    
}
