//
//  ButtonX.swift
//  chefling
//
//  Created by Sanjay Mali on 24/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

@IBDesignable public class ButtonX: UIButton {
        @IBInspectable var borderColor:UIColor = UIColor.darkGray {
            didSet{
                layer.borderColor = UIColor(hex:"d2d2d2").cgColor
            }
        }
        @IBInspectable var borderWidth: CGFloat = 1.0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        @IBInspectable var cornerRadius: CGFloat = 2.0 {
            didSet {
                layer.cornerRadius = cornerRadius
            }
        }
        @IBInspectable var masksToBounds: Bool = true {
            didSet {
                layer.masksToBounds = masksToBounds
            }
    }
    
    @IBInspectable public var background:UIColor = UIColor(hex:"85bb38") {
        didSet{
            layer.borderColor = UIColor.black.cgColor
        }
    }
}
