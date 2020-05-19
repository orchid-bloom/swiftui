//
//  LocalJSON.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation

struct Mock<T: Decodable>: Decodable {
  let data: T
}


func LocalJSON<T: Decodable>(name: String) -> T {
  let url = Bundle.main.url(forResource: name, withExtension: "json")!
  do {
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    let result = try decoder.decode(Mock<T>.self, from: data)
    return result.data
  } catch {
    fatalError(error.localizedDescription)
  }
}
