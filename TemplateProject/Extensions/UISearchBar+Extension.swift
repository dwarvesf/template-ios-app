//
//  UISearchBar+Extension.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    var searchTextField: UITextField {
        get {
            var textfield = UITextField()
            for view in self.subviews {
                for subView in view.subviews {
                    if subView.isKind(of: UITextField.self) {
                        textfield = subView as! UITextField
                        return textfield
                    }
                }
            }
            return textfield
        }
    }
    
    var cancelButton: UIButton {
        get {
            var button = UIButton()
            for view in self.subviews {
                for subView in view.subviews {
                    if subView is UIButton {
                        button = subView as! UIButton
                        return button
                    }
                }
            }
            return button
        }
    }
}
