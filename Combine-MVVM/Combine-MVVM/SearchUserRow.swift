//
//  SearchUserRow.swift
//  Combine-MVVM
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import UIKit

struct SearchUserRow: View {
  
  var user: User
  
  var body: some View {
    HStack{
      KFImage(user.avatar_url)
        .resizable()
        .frame(width: 44, height: 44)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.black.opacity(0.3), lineWidth: 1))
        .padding([.trailing], 8)
      Text(user.login)
    }
  }
}


