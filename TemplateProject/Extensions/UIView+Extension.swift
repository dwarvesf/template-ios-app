//
//  UIView+Extension.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func border(color: UIColor = UIColor.clear, radius: CGFloat = 0, width: CGFloat = 0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    var sizeWidth: CGFloat {
        get { return self.frame.size.width }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var sizeHeight: CGFloat {
        get { return self.frame.size.height }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
}
