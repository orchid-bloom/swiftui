//
//  ContentView.swift
//  Keychain+FaceID
//
//  Created by Tema.Tian on 2020/6/5.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
      setup()
    }
  
  func setup() -> some View {
     
    print(BiometricsHelper.isFingerprintChange())
    
    return Button(action: {
      BiometricsHelper.deviceOwnerAuthenticationWithBiometrics(title: "认证", fallbackTitle: "返回", fallbackBlock: {
        
      }) { (success, status, error) in
        print(BiometricsHelper.isFingerprintChange())
      }
    }, label: {
      Text("CLICK")
    })
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
