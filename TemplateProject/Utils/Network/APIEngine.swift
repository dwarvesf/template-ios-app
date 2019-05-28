//
//  APIEngine.swift
//  TemplateProject
//
//  Created by TrungPhan on 7/4/18.
//  Copyright © 2018 Dwarvesv. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class APIEngine {
    static func queryData<T: Codable> (method: HTTPMethod, url:URLConvertible, parameters: [String:Any]?, header: [String: String]?) -> Observable<T> {
        return RxAlamofire.requestData(method, url, parameters: parameters, encoding: JSONEncoding.default, headers: header).mapObject(type: T.self)
    }
    static func queryArrayData<T: Codable> (method: HTTPMethod, url:URLConvertible, parameters: [String:Any]?, header: [String: String]?) -> Observable<[T]> {
        return RxAlamofire.requestData(method, url, parameters: parameters, encoding: JSONEncoding.default, headers: header).mapArray(type: T.self)
    }
}
extension ObservableType {
    
    public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap {  data -> Observable<T> in
            
            let invalidJSON = NetworkError.Error(message: "Invalid Response")
            
            guard let (httpResponse, jsonData) = data as? (HTTPURLResponse, Data) else {
                throw invalidJSON
            }
            
            guard (200..<300).contains(httpResponse.statusCode)
                else {
                    if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                        let message = jsonDict["error"] as? String {
                        throw NetworkError.Error(message: message)
                    }
                    throw invalidJSON
                }
            
            #if DEVELOPMENT
            print("\(String(describing: httpResponse.allHeaderFields.debugDescription))------------------------")
            print(String(data: jsonData, encoding:.utf8)?.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil) as Any )
            #endif
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let object = try decoder.decode(T.self, from: jsonData)
                return Observable.just(object)
            } catch {
                throw invalidJSON
            }
        }
    }
    
    public func mapArray<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap {  data -> Observable<[T]> in
            
            let invalidJSON = NetworkError.Error(message: "Invalid Response")
            
            guard let (httpResponse, jsonData) = data as? (HTTPURLResponse, Data) else {
                throw invalidJSON
            }
            
            guard (200..<300).contains(httpResponse.statusCode)
                else {
                    if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                        let message = jsonDict["error"] as? String {
                        throw NetworkError.Error(message: message)
                    }
                    throw invalidJSON
            }
            
            #if DEVELOPMENT
            print("\(String(describing: httpResponse.allHeaderFields.debugDescription))------------------------")
            print(String(data: jsonData, encoding:.utf8)?.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil) as Any )
            #endif
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            //=> handle backend may wrape array in key data
            
            if let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                let jsonArr = jsonDict["data"] as? [[String: Any]],
                let data = try? JSONSerialization.data(withJSONObject: jsonArr, options: []),
                let object = try? decoder.decode([T].self, from: data) {
                return Observable.just(object)
            } else if let object = try? decoder.decode([T].self, from: jsonData) {
                return Observable.just(object)
            } else {
                throw invalidJSON
            }
        }
    }
}
