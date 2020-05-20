//
//  message.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct Message: Codable, Identifiable {
  
  let id = UUID()
  let createdAt: Date
  let image: Media?
  let member: Member
  let text: String?
  let type: MessageType
  let voice: String?
  let video: Media?
  
}

extension Message {
  
  enum MessageType: String, Codable {
    case text
    case image
    case voice
    case video
  }
}
