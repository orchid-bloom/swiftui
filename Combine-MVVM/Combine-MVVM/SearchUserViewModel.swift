//
//  SearchUserViewModel.swift
//  Combine-MVVM
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Combine
import SwiftUI

final class SearchUserViewModel: ObservableObject {
  
  @Published var text = "Tema"
  
  @Published var users: [User] = []
  
  private var searchCancellable: Cancellable? {
    didSet {
      oldValue?.cancel()
    }
  }
  
  deinit {
    searchCancellable?.cancel()
  }
  
  func search() {
    if text.isEmpty { return users = [] }
    
    var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
    urlComponents.queryItems = [
      URLQueryItem(name: "q", value: text)
    ]
    
    var request = URLRequest(url: urlComponents.url!)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
      .map{$0.data}
      .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
      .map({$0.items})
      .replaceError(with: [])
      .receive(on: RunLoop.main)
      .assign(to: \.users, on: self)
  }
  
}


