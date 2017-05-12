//
//  CircleView.swift
//  devslopes-social
//
//  Created by Fain Cowie on 2017-05-10.
//  Copyright © 2017 Fain Cowie. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2

    }

    
}
