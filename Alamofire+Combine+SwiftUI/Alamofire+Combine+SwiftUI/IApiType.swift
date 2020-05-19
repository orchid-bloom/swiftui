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

protocol IApiType {
  associatedtype ResponseType
  var method: HTTPMethod { get }
  var baseURL: URL { get }
  var path: String { get }
  var headers: [String: String] { get }
}

extension IApiType {

  var baseURL: URL {
    return try! NetworkConfig.baseURL.asURL()
  }

  var headers: [String: String]? {
    return nil
  }

}

// MARK: - BaseRequestProtocol

protocol BaseRequestProtocol: IApiType, URLRequestConvertible {
  var parameters: Parameters { get }
  var encoding: URLEncoding { get }
}

extension BaseRequestProtocol {

  var parameters: Parameters {
    return [:]
  }
  
  var encoding: URLEncoding {
    return URLEncoding.default
  }

  func asURLRequest() throws -> URLRequest {
    var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = headers
    urlRequest.timeoutInterval = TimeInterval(30)
    urlRequest = try encoding.encode(urlRequest, with: parameters)
    return urlRequest
  }
}
