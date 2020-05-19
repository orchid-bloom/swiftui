//
//  BaseAPIProtocol.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Combine
import Foundation
import Alamofire

// MARK: - Base API Protocol

protocol TargetType {
  associatedtype ResponseType
  
  var method: HTTPMethod { get }
  var baseURL: URL { get }
  var path: String { get }
  var headers: [String : String]? { get }
}

extension TargetType {
  
  var baseURL: URL {
    return try! NetworkConstants.baseURL.asURL()
  }
  
  var headers: [String : String]? {
    return nil
  }

}

// MARK: - BaseRequestProtocol

protocol BaseRequestProtocol: TargetType, URLRequestConvertible {
  var parameters: Parameters? { get }
  var encoding: URLEncoding { get }
}

extension BaseRequestProtocol {
  
  var encoding: URLEncoding {
    return URLEncoding.default
  }
  
  func asURLRequest() throws -> URLRequest {
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = headers
    urlRequest.timeoutInterval = TimeInterval(30)
    
    if let params = parameters {
      urlRequest = try encoding.encode(urlRequest, with: params)
    }
    
    return urlRequest
  }
}
