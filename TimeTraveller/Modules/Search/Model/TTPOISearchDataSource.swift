//
//  TTPOISearchDataSource.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 1/28/16.
//  Copyright © 2016 Oborn.Jung. All rights reserved.
//

import OBUIKit

class TTPOISearchDataSource: OBBaseTableDataSource {
    
    override func setDataSource(dataSource: [[OBBaseComponentModel]]?) {
        var regularDataSource: [[OBBaseComponentModel]]?;
        if let oriDataSource = dataSource {
            regularDataSource = [[OBBaseComponentModel]]();
            for sectionData in oriDataSource {
                var regularSectionData = [OBBaseComponentModel]();
                for component in sectionData {
                    regularSectionData.append(component);
                    let separator = OBSeparatorModel(separatorStyle: .Line);
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
}
