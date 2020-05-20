//
//  SceneDelegate.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
    guard let windowScene = scene as? UIWindowScene else { return }
    
    configureAppearance()
    configureWindow(windowScene: windowScene)
    
  }
  
  func configureAppearance() {
    UITableView.appearance().backgroundColor = .clear
    UITableView.appearance().separatorStyle = .none
    
    let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
    UINavigationBar.appearance().backIndicatorImage = backImage
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().tintColor = UIColor(named: "navigation")
    UINavigationBar.appearance().barTintColor = UIColor(named: "navigation")
  }
  
  func configureWindow(windowScene: UIWindowScene) {
     let rootView = RootView()
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = HostingController(rootView: rootView)
    window?.makeKeyAndVisible()
  }
}

