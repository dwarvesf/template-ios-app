//
//  UIViewController+Alert.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlert(title:String?,
                   message: String,_
        actions:UIAlertAction...) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertAction(title:String?,
                         message: String?,_
        actions:UIAlertAction...) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
