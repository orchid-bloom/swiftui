//
//  IResponse.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol Response {
  
  var data: [String: Any] { get }
  
  var response: AFDataResponse<Any> { get }
}

class MoyaResponse: Response {
  
  private var _data: [String: Any]!
  /// Moya response
  private var _response: AFDataResponse<Any>
  
  var data: [String: Any] {
    if _data == nil {
      return [:]
    }
    return _data
  }
  
  var response: AFDataResponse<Any> {
    return _response
  }
  
  init(_ response: AFDataResponse<Any>) {
    
    _response = response
    
    var dict: Any?
    
    do {
      
      dict = try mapJSON()
      
    } catch let error {
      #if Debug
      print(error.localizedDescription)
      #endif
    }
    if let map = dict as? [String : Any] {
      
      _data = map
      
    } else if let dataList = dict as? [Any] {
      
      _data = ["data" : dataList]
      
    }
  }
}

extension Response {
  /// 返回Any
  /// - 描述: 将response转换为Any
  func mapJSON(failsOnEmptyData: Bool = true) throws -> Any {
    let mapData = response.data ?? Data()
    do {
      return try JSONSerialization.jsonObject(with: mapData, options: .allowFragments)
    } catch {
      if mapData.count < 1 && !failsOnEmptyData {
        return NSNull()
      }
      throw RestError.error(error: "map to JSON error")
    }
  }
}
