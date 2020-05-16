//
//  SearchUserView.swift
//  Combine-MVVM
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct SearchUserView: View {
    
  @ObservedObject var viewModel = SearchUserViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        SearchUserBar(text: $viewModel.text, action:  viewModel.search)
        
        List(viewModel.users) { user in 
          SearchUserRow(user: user)
        }
      }
      .navigationBarTitle(Text("Users"))
    }
  }
}

struct SearchUserView_Previews: PreviewProvider {
  static var previews: some View {
    SearchUserView()
  }
}

