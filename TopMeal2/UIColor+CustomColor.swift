//
//  UIColor+CustomColor.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 07/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func fromRgbHex(_ fromHex: Int) -> UIColor {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func withAbsoluteRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/256, green: green/256, blue: blue/256, alpha: 1.0)
    }
    
    class func topMealGreen() -> UIColor {
        
        return UIColor.withAbsoluteRGB(red: 140.0, green: 205.0, blue: 152.0)
    }
}
