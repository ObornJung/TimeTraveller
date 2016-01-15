//
//  TTBaseView.swift
//  TimeTraveller
//
//  Created by Oborn.Jung on 12/24/15.
//  Copyright © 2015 Oborn.Jung. All rights reserved.
//

import UIKit

class TTBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setupViews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.setupViews();
    }
    
    func setupViews() {}
}
