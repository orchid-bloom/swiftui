
//
//  ChatView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct ChatView: View {
  
  @ObservedObject var viewModel = ChatViewModel()
  
  var body: some View {
    ZStack {
      List(viewModel.messages) { message in
        ChatCell(message: message)
      }
    }
    .navigationBarTitle(Text("聊天"))
  }
}

struct ChatView_Previews: PreviewProvider {
  static var previews: some View {
    ChatView()
  }
}

struct ChatCell: View {
  
  let message: Message
  
  var body: some View {
    VStack(spacing: 6) {
      Text(message.text ?? "")
        .padding()
        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
    }
    .background(background())
  }
  
  private func background() -> some View {
    return RoundedRectangle(cornerRadius: 3)
      
      .foregroundColor(Color("chat_me_background"))
  }
}





