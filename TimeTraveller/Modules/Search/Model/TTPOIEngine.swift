//
//  TTPOIEngine.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/28/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit
import Foundation

class TTPOIEngine: NSObject {
    
    var dataSource: TTPOISearchDataSource;
    
    init(dataSource: TTPOISearchDataSource) {
        self.dataSource = dataSource;
        super.init();
    }
    
    func updateSuggestion(keyworld: String, region: MKCoordinateRegion?, completion: (([[OBBaseComponentModel]]?) -> Void)? = nil) {
        TTPOISearchService.sharedInstance.searchPOI(keyworld, region: region).subscribeNext {[weak self] (object: AnyObject!) -> Void in
            let poisDataSource = self?.parseData(object);
            self?.dataSource.setDataSource(poisDataSource);
            completion?(poisDataSource);
        }
    }
    
    func parseData(data: AnyObject?) -> [[OBBaseComponentModel]]? {
        
        if let response = data as? AMapPOISearchResponse {
            var poisDataSource = [OBBaseComponentModel]();
            for poi in response.pois {
                let poiModel = TTPOIModel();
                poiModel.tag = kTTPOIModelKey;
                poiModel.poi = poi as? AMapPOI;
                poisDataSource.append(poiModel);
            }
            if poisDataSource.count > 0 {
                return [poisDataSource];
            }
        }
        return nil;
    }
}
