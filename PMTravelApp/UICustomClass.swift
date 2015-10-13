//
//  UIExtension.swift
//  PMTravelApp
//
//  Created by MaiMai on 10/13/15.
//  Copyright © 2015 MaiMai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class customView : UIView{
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
}

