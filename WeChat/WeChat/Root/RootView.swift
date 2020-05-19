//
//  ContentView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import Combine

struct RootView: View {
  
  @ObservedObject var viewModel = RootViewModel()
  
  let homeView = HomeView()
  let contanctView = ContactView()
  let discoverView = DiscoverView()
  let meView = MeView()
  
  var body: some View {
    NavigationView {
      TabView(selection: $viewModel.tabSelection) {
        homeView
          .tabItem{Item(index: $viewModel.tabSelection, style: .chat)}
          .tag(0)
        contanctView
          .tabItem{Item(index: $viewModel.tabSelection, style: .contact)}
          .tag(1)
        discoverView
          .tabItem{Item(index: $viewModel.tabSelection, style: .discover)}
          .tag(2)
        meView
          .tabItem{Item(index: $viewModel.tabSelection, style: .me)}
        .tag(3)
      }
      .accentColor(.green)
      .navigationBarHidden(viewModel.tabNavigationHidden)
      .navigationBarItems(trailing: viewModel.tabNavigationBarTrailingItems)
      .navigationBarTitle(viewModel.tabNavigationTitle, displayMode: .inline)
      .environmentObject(viewModel)
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
#endif

private struct Item: View {
  @Binding var index: Int
  
  let style: Style
  
  var body: some View {
    VStack{
      if index == style.rawValue {
        style.selectedImage
      } else {
        style.image
      }
      Text(style.text)
    }
  }
}

extension Item {
  enum Style: Int {
    case chat
    case contact
    case discover
    case me
    
    var image: Image {
      switch self {
      case .chat:     return Image("root_tab_chat")
      case .contact:  return Image("root_tab_contact")
      case .discover: return Image("root_tab_discover")
      case .me:       return Image("root_tab_me")
      }
    }
    
    var selectedImage: Image {
      switch self {
      case .chat:     return Image("root_tab_chat_selected")
      case .contact:  return Image("root_tab_contact_selected")
      case .discover: return Image("root_tab_discover_selected")
      case .me:       return Image("root_tab_me_selected")
      }
    }
    
    var text: String {
      switch self {
      case .chat:     return "微信"
      case .contact:  return "通讯录"
      case .discover: return "发现"
      case .me:       return "我"
      }
    }

  }
}

