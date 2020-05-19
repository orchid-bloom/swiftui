//
//  TestApi.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/18.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

enum TestApi: TargetType {

  case item
  
  var headers: [String : String] {
    return [:]
  }
  
  var parameters: Parameters {
    return [:]
  }
  
  var method: Method {
    return .get
  }
  
  var path: String {
    return "items"
  }
  
  var nestedKeys: String {
    return "data"
  }
}
