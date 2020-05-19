//
//  ContentView.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import Combine

struct TopView: View {
  
  @ObservedObject var observed = TopViewModel()
  
  var body: some View {
    NavigationView {
      List(observed.displayData.indices, id: \.self) { index in
        TopViewRow(displayData: self.$observed.displayData[index])
      }
      .navigationBarTitle("新着", displayMode: .automatic)
    }.onAppear(perform: observed.onAppear)
      .alert(isPresented: $observed.showAlert,
             content: {
              Alert(title: Text("Error"),
                    message: Text("\(observed.errorCode)"),
                    dismissButton: .default(Text("Error"),
                                            action: {
                                              self.observed.getItems()
                    }))
      }
    )
  }
}

struct TopViewRow: View {
  
  @Binding var displayData: ItemsResponse
  
  var body: some View {
    VStack {
      HStack {
        Text(displayData.user.id ?? "")
        Spacer()
      }
      HStack {
        Text(displayData.title)
        Spacer()
      }
      HStack {
        ForEach(displayData.tags, id: \.name) { tag in
          Text(tag.name ?? "")
            .padding(.horizontal, 5.0)
            .padding(.vertical, 3.0)
            .background(Color.gray)
            .font(Font.system(size: 10, weight: .light, design: .default))
            .cornerRadius(5)
        }
        Spacer()
      }
    }
  }
}
