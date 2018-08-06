//
//  UIColor+Extension.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(red: Double, green: Double, blue: Double) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
    }
    class func colorWithHex( hex:UInt ) -> UIColor {
        
        var redChannel, greenChannel, blueChannel:CGFloat
        
        redChannel = CGFloat((hex >> 16) & 0xff) / 0xff
        greenChannel = CGFloat((hex >> 8) & 0xff) / 0xff
        blueChannel = CGFloat((hex >> 0) & 0xff) / 0xff
        
        return UIColor(red: redChannel, green: greenChannel, blue: blueChannel, alpha: 1.0)
        
    }
}
