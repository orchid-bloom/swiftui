//
//  StatusBarStyle.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

extension EnvironmentValues {
  var statusBarStyle: StatusBarStyle { return self[StatusBarStyle.Key.self] }
}

class StatusBarStyle {
  var getter: () -> UIStatusBarStyle = { .default }
  var setter: (UIStatusBarStyle) -> Void = { _ in }
  
  var current: UIStatusBarStyle {
    get { getter() }
    set { setter(newValue) }
  }
}

extension StatusBarStyle {
  struct Key: EnvironmentKey {
    static var defaultValue: StatusBarStyle = StatusBarStyle()
  }
}
