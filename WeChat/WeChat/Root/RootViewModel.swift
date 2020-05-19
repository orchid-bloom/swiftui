//
//  RootViewModel.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Combine
import SwiftUI

class RootViewModel: ObservableObject {
  
  @Published var tabSelection = 0
  
  @Published var tabNavigationHidden: Bool = false
  
  @Published var tabNavigationTitle: LocalizedStringKey = ""
  
  @Published var tabNavigationBarTrailingItems: AnyView = .init(EmptyView())

}
