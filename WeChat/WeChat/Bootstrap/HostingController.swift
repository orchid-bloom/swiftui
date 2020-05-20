//
//  HostingController.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import Combine

class HostingController<Content: View>: UIHostingController<HostingMiddle<Content>> {
  
  private var statusBarStyle: UIStatusBarStyle = .default {
    didSet {
      if (oldValue != statusBarStyle) {
        setNeedsStatusBarAppearanceUpdate()
      }
    }
  }
  
  init(rootView: Content) {
    super.init(rootView: HostingMiddle(content: rootView))
    
    StatusBarStyle.Key.defaultValue.getter = { self.statusBarStyle }
    StatusBarStyle.Key.defaultValue.setter = { self.statusBarStyle = $0}
  }
  
  @objc required dynamic init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    statusBarStyle
  }
}


struct HostingMiddle<Content: View>: View {

  let content: Content
  
  var body: some View {
     content
  }
}
