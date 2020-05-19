//
//  NetworkPublisher.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Alamofire
import Combine
import Foundation

// MARK: - NetworkPublisher

protocol IResponse {
  
}

struct NetworkPublisher {

  // MARK: - Constants

  private static let successRange = 200 ..< 600
  private static let contentType = "application/json"
  static let decorder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
  }()

  // MARK: - Methods

  static func publish<T, V>(_ request: T) -> Future<V, RestError>
  where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {
    return Future { promise in
      let api = AF.request(request)
        .validate(statusCode: self.successRange)
        .validate(contentType: [self.contentType])
        .cURLDescription { text in
          print(text)
        }
        .responseJSON { response in
          switch response.result {
          case .success:
            do {
              if let data = response.data {
                let json = try self.decorder.decode(V.self, from: data)
                promise(.success(json))
              } else {
                promise(.failure(RestError.error(error: "Response json is empty")))
              }

            } catch {
              promise(.failure(RestError.error(error: "Mapping error")))
            }
          case let .failure(error):
            promise(.failure(RestError.error(error: error.errorDescription ?? "")))
          }
      }
      api.resume()
    }
  }
}



