//
//  MomentViewModel.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation
import Combine

class MomentViewModel: ObservableObject {
  
  @Published var moments: [Moment] = []
  @Published var me: Member = LocalJSON(name: "me")
    
  init() {
    DispatchQueue.global().async {
      let moments: [Moment] = LocalJSON(name: "moments")
      let me: Member = LocalJSON(name: "me")
      DispatchQueue.main.async {
        self.moments = moments
        self.me = me
      }
    }
  }
}
