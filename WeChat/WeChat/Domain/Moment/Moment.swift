//
//  Moment.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct Moment: Codable, Identifiable {
  
  let id = UUID()
  let author: Member
  let comments: [Comment]?
  let images: [Media]?
  let likes: [String]?
  let text: String?
  let time: String
  let video: Media?
  
}

struct Comment: Codable, Identifiable {
  
  let id = UUID()
  let name: String
  let content: String
  
}
