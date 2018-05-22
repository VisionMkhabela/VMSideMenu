//
//  VMMenuConfig.swift
//  SideMenu
//
//  Created by Vision Mkhabela on 5/17/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit

public struct MenuConfig {
    
    public static var heightDiff: CGFloat = 0
    public static var storyboardName: String = ""
    public static var viewControllerId: String = ""
    
    public static func reduceHeight(by constant: CGFloat) {
        self.heightDiff = constant
    }
}
