//
//  Provider.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

class RestService: IRest {

  fileprivate var _timeoutInterval: TimeInterval = 60
  fileprivate var _globalHeaders = [String: String]()
  fileprivate var _globalParameters = Parameters()

  public var timeoutInterval: TimeInterval {
    get {
      return _timeoutInterval
    }
    set {
      _timeoutInterval = newValue
    }
  }

  public var globalHeaders: [String: String] {
    get {
      return _globalHeaders
    }
    set {
      _globalHeaders.merge(newValue)
    }
  }

  public var globalParameters: [String: Any] {
    get {
      return _globalParameters
    }
    set {
      _globalParameters.merge(newValue)
    }
  }


  func launch(_ request: TargetType) -> Future<JSON, RestError> {
    return Future { promise in
      let api = AF.request(request)
        .validate(statusCode: 200 ..< 600)
        .cURLDescription { text in
          print(text)
        }
        .responseJSON { response in
          switch response.result {
          case .success:
            var json = JSON(MoyaResponse(response).data)
            if !request.nestedKeys.isEmpty {
              json = json.mapJSONForKey(request.nestedKeys)
            }
            promise(.success(json))
          case let .failure(error):
            promise(.failure(RestError.error(error: error.errorDescription ?? "AF responseJSON result failure")))
          }
      }
      api.resume()
    }
  }
}

