//
//  StyledView.swift
//  NSFAS
//
//  Created by Vision Mkhabela on 5/12/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StyledView: UIView {
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
            layer.masksToBounds = false
            
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius

        }
    }
}
