//
//  IRest.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/18.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//
import Combine
import SwiftUI

let Rest = RestService()

public enum RestError: Error {
  case error(error: String)
}

public protocol IRest {
  
  var timeoutInterval: TimeInterval { set get }
  
  var globalHeaders: [String: String] { set get }
  
  var globalParameters: Parameters { set get }
  
  func launch(_ request: TargetType) -> Future<JSON, RestError>
  
}

