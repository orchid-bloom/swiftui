//
//  ItemsRequest.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Alamofire

class ItemsRequest: BaseRequestProtocol {
  
  var headers: [String : String] {
    return [:]
  }
  
  var parameters: Parameters {
    return [:]
  }

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    return "items"
  }

  typealias ResponseType = [ItemsResponse]

}
