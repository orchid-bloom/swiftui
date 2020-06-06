//
//  Extension.swift
//  Keychain+FaceID
//
//  Created by Tema.Tian on 2020/6/6.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

public extension Optional {
  /// 可选值为空的时候返回 true
  var isNone: Bool {
    switch self {
    case .none:
      return true
    case .some:
      return false
    }
  }
  
  /// 可选值非空返回 true
  var isSome: Bool {
    return !isNone
  }
}
