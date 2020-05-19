//
//  Separator.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct Separator: View {
  let color: Color
  
  var body: some View {
    Divider()
      .overlay(color)
      .padding(.zero)
  }
  
  init(color: Color = Color("separator")) {
    self.color = color
  }
}
