//
//  SearchUserBar.swift
//  Combine-MVVM
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct SearchUserBar: View {
  
  @Binding var text: String
  
  @State var action: () -> Void
  
  var body: some View {
    ZStack{
      Color.yellow
      HStack {
        TextField("Search User", text: $text)
          .foregroundColor(Color.black.opacity(0.8))
        .padding([.leading, .trailing], 8)
        .frame(height: 32)
          .background(Color.white.opacity(0.4))
        .cornerRadius(8)
        Button(action: action) {
          Text("Search")
            .foregroundColor(.white)
        }
        .padding([.leading, .trailing], 16)
      }
    }
    .frame(height: 64)
  }
}


