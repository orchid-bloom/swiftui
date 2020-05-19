//
//  HomeViewModel.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
  
  @Published var chats:[Chat]  = LocalJSON(name: "chats")

}
