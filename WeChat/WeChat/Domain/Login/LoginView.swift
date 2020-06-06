//
//  LoginView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/6/4.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
  
  @ObservedObject var viewModel = LoginViewModel()
  let laContent = LAContext()

  var body: some View {
    Button(action: {
      self.starBiometricAuthentication()
    }, label: {
      Text("身份认证")
    }).onAppear {
      self.localAuthentication()
    }
  }
  
  func localAuthentication() {
    var authError: NSError?
    let isCanEvaluatePolicy = laContent.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError)
    if (authError != nil) {
      print("FaceID 或者 TOUCH ID 当前不可用！\n error : == \(String(describing: authError?.localizedDescription))")
    } else {
      if isCanEvaluatePolicy {
        switch laContent.biometryType {
        case .none:
          print("该设备支持不支持FaceID和TouchID")
        case .touchID:
          print("该设备支持TouchID")
        case .faceID:
          print("该设备支持Face ID")
        @unknown default: break
        }
      }
    }
  }
  
  func starBiometricAuthentication() {
    laContent.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "身份认证") { (success, error) in
      if success {
        print("验证成功")
        return
      }
      guard let e = error as NSError? else { return }
      print("身份验证失败！errorCode: \(e.code) errorMsg : \(e.localizedDescription)")
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}

