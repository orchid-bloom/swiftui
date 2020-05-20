//
//  MeViewModel.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation
import Combine

class MeViewModel: ObservableObject {
  @Published var me: Member = LocalJSON(name: "me")
}
