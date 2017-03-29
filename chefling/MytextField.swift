//
//  MytextField.swift
//  chefling
//
//  Created by Sanjay Mali on 23/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

class MytextField: UITextField {
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath(roundedRect: rect, cornerRadius:8)
            UIColor.clear.setFill()
            path.fill()
            UIColor(hex:"d2d2d2").setStroke()
            path.lineWidth = 1
            let dashPattern : [CGFloat] = [10,3]
            path.setLineDash(dashPattern, count: 2
                , phase: 0)
            self.layer.cornerRadius = 8.0
            self.layer.borderColor = UIColor(hex:"#D2D2D2").cgColor
            path.stroke()
    }
}
