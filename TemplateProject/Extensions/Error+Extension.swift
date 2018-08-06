//
//  Error+Extension.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
enum NetworkError:Error {
    case Error(message:String)
}
extension Error {
    func description() -> String {
        if let error = self as? NetworkError {
            switch error {
            case .Error(message: let message):
                return message
            }
        }else {
            return self.localizedDescription
        }
    }
}
