//
//  UIImageView+Kingfishser.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

public extension UIImageView {
    
    func setImageWithURLString(URLString: String, placeholderImage placeholder: UIImage? = nil) {
        guard let URL = URL(string: URLString) else {
            print("URL wrong")
            return
        }
        
        self.kf.setImage(with: URL, placeholder: placeholder)
    }
}
