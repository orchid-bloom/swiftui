//
//  Contact.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct Contact: Codable, Identifiable {
  
  let id = UUID()
  let letter: String
  let members: [Member]
  
}
