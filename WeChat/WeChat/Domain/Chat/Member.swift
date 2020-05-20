//
//  Member.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct Member: Codable, Identifiable {
  
  let id = UUID()
  let background: String?
  let icon: String
  let identifier: String?
  let name: String
  
}


struct Media: Codable, Identifiable {
  
  let id = UUID()
  let cover: String?
  let width: Double?
  let height: Double?
  let url: String
  
}
