//
//  Chat.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct Chat: Codable, Identifiable {
  
  let id = UUID()
  let icon: String
  let name: String
  let desc: String
  let time: String
  
}
