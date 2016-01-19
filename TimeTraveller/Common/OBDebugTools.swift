//
//  OBDebugTools.swift
//  OBSuperCalculator
//
//  Created by Oborn.Jung on 12/24/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import Foundation

func OBLog(message: String, function: String = __FUNCTION__, line: Int = __LINE__) {
    #if DEBUG
        print("\(function) [Line \(line)] --By ObornJung-- \(message)")
    #endif
}