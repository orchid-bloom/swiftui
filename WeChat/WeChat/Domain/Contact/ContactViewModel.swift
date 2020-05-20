//
//  ContactViewModel.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

class ContactViewModel: ObservableObject {
  
  @Published var contacts: [Contact] = LocalJSON(name: "contacts")
  
}
