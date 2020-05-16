//
//  User.swift
//  Combine-MVVM
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct SearchUserResponse: Decodable {
  var items: [User]
}

struct User: Identifiable, Hashable, Decodable {
  var id: Int
  var login: String
  var avatar_url: URL
}
