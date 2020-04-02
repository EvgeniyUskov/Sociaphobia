//
//  UIHelper.swift
//  Sociaphobia 2
//
//  Created by Evgeniy Uskov on 30.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation
import UIKit

class UIHelper{
    static func getViewBackgroundColor() -> UIColor {
        return UIColor.hexValue(hex: "f5f5f5")
    }
    
    static func getCellBackgroundColor() -> UIColor {
        return UIColor.hexValue(hex: "ffffff")
    }
    
    static func getButtonBackgroundColor() -> UIColor {
        return UIColor.hexValue(hex: "372eef")
    }
    
    static func getTextForegroundColor() -> UIColor {
        return UIColor.hexValue(hex: "2b2b2b")
    }
}

extension UIColor {
    static func hexValue(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
