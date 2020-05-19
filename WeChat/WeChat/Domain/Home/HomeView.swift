//
//  HomeView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {

  @EnvironmentObject var root: RootViewModel
  @ObservedObject var viewModel = HomeViewModel()
  @Environment(\.presentationMode) var presentation
//  self.presentation.wrappedValue.dismiss()

  var body: some View {
    ZStack {
      VStack {
        Color("light_gray").frame(height: 300)
        Spacer()
      }
      List {
        SearchEntryView()
        Group {
          ForEach(viewModel.chats) { chat in
            HomeCell(chat: chat)
              .listRowInsets(.zero)
              .navigationLink(destination: ChatView())
          }
        }
      }
    }
      .onAppear {
        self.root.tabNavigationHidden = false
        self.root.tabNavigationTitle = "微信"
        self.root.tabNavigationBarTrailingItems = .init(Image(systemName: "plus.circle"))
    }
  }
}

#if DEBUG
  struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView()
        .environmentObject(RootViewModel())
    }
  }
#endif

struct HomeCell: View {

  let chat: Chat

  var body: some View {
    VStack {
      HStack(spacing: 12) {
        Image(chat.icon)
          .renderingMode(.original)
          .resizable()
          .frame(width: 48, height: 48)
          .cornerRadius(8)

        VStack(alignment: .leading, spacing: 5) {
          HStack(alignment: .top) {
            Text(chat.name)
              .font(.system(size: 16, weight: .regular))
              .foregroundColor(.primary)
            Spacer()
            Text(chat.time)
              .font(.system(size: 10))
              .foregroundColor(.secondary)
          }

          Text(chat.desc)
            .lineLimit(1)
            .font(.system(size: 15))
            .foregroundColor(.secondary)
        }
      }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))

      Separator().padding(.leading, 60)
    }
  }
}


