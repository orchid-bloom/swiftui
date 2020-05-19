//
//  NetworkConstants.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

class NetworkConfig: NSObject {

  // MARK: - Variables

  static var baseURL: String = {
    #if DEBUG
      return "https://qiita.com/api/v2/"
    #else
      return "https://qiita.com/api/v2/"
    #endif
  }()

}
