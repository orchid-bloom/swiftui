//
//  TargetType.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

public protocol TargetType: URLRequestConvertible {
  var baseURL: URL { get }
  var path: String { get }
  var method: Method { get }
  var headers: [String: String] { get }
  var parameters: Parameters { get }
  var encoding: URLEncoding { get }
  var nestedKeys: String { get }
}

// MARK: - TargetType extension suppurt
extension TargetType {
  
  var baseURL: URL {
    return try! NetworkConfig.baseURL.asURL()
  }
  
  var nestedKeys: String {
    return ""
  }
  
  var headers: [String: String] {
    return [:]
  }
  
  var parameters: Parameters {
    return [:]
  }
  
  var encoding: URLEncoding {
    return URLEncoding.default
  }
  
  func asURLRequest() throws -> URLRequest {
    var allHeaders = headers
    allHeaders.merge(Rest.globalHeaders, uniquingKeysWith: +)
    var allparameters = parameters
    Rest.globalParameters.forEach { (k,v) in
      allparameters[k] = v
    }
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = allHeaders
    urlRequest.timeoutInterval = TimeInterval(30)
    urlRequest = try encoding.encode(urlRequest, with: allparameters)
    return urlRequest
  }
}






