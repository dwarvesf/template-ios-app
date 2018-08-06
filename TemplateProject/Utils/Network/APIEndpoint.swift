//
//  APIEndpoint.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation

class APIEndpoint {
    #if DEVELOPMENT
    public static let baseURL: String = "https://dev.com"
    #else //Production
    public static let baseURL: String = "https://production.com"
    #endif
}
