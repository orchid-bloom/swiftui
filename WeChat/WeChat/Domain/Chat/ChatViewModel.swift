//
//  ChatViewModel.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
  
  @Published var messages: [Message] = LocalJSON(name: "messages")
  
}
