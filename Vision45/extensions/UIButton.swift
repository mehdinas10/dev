//
//  UIButton.swift
//  Vision45
//
//  Created by Mehdi Nasiri on 4/3/21.
//  Copyright © 2021 Mehdi Nasiri. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton{
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
