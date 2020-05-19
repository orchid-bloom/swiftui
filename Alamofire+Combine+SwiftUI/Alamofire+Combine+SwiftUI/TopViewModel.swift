//
//  TopViewModel.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/16.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Combine
import Alamofire
import Foundation
import SwiftyJSON

class TopViewModel: ObservableObject {

  @Published var displayData: [ItemsResponse] = []
  @Published var errorCode: String = ""
  @Published var showAlert: Bool = false

  var task: AnyCancellable? = nil

  private(set) lazy var onAppear: () -> Void = { [weak self] in
    self?.getItems()
  }

  func getItems() {
    self.task = Rest.launch(TestApi.item)
      .sinkArray(ItemsResponse.self, receiveValue: { data in
        self.displayData = data
        print(data)
      })
//    self.task = RestService().publish(TestApi())
//      .sinkArray(ItemsResponse.self, receiveValue: { data in
//        self.displayData = data
//        print(data)
//      })
//    self.task = Provider().publish(TestApi())
//      .receive(on: DispatchQueue.main)
//      .sink(receiveCompletion: { completion in
//        switch completion {
//        case .finished:
//          print("成功")
//        case let .failure(error):
//          print(error)
//          self.errorCode = error.localizedDescription
//          self.showAlert = true
//        }
//      }, receiveValue: { data in
//        let json = data
//        self.displayData = (try? json.decodeArray(ItemsResponse.self)) ?? []
//        self.errorCode = ""
//        self.showAlert = false
//      })


//    self.task = NetworkPublisher.publish(ItemsRequest())
//      .receive(on: DispatchQueue.main)
//      .sink(receiveCompletion: { completion in
//        switch completion {
//        case .finished:
//          print("成功")
//        case let .failure(error):
//          print(error)
//          self.errorCode = error.localizedDescription
//          self.showAlert = true
//        }
//      }, receiveValue: { data in
//              self.displayData = data
//              self.errorCode = ""
//              self.showAlert = false
//      })
  }
}

//extension Future where Output == JSON, Failure == RestError {
//  func tryMap<T: Decodable>(_ type: T.Type) -> Publishers.TryMap<Future<JSON, RestError>, T> {
//    let s = self.tryMap { (json) -> T in
//      do {
//        return try json.decodeObject(type)
//      } catch {
//        throw RestError.error(error: "map json to Codable List failed")
//      }
//    }
//    return s
//  }
//
//  func map1<T: Decodable>(_ type: T.Type) -> Publishers.Map<Future<JSON, RestError>, T> {
//    let s = self.map({ (json) -> T in
//      return try! json.decodeObject(type)
//    })
//    return s
//  }
//
//  func sink(receiveValue: @escaping ((JSON) -> Void)) -> AnyCancellable {
//    return self.receive(on: DispatchQueue.main)
//      .sink(receiveCompletion: { (completion) in
//        switch completion {
//        case .finished:
//          _ = self.print("request finished")
//        case .failure(let error):
//          _ = self.print(error.localizedDescription)
//        }
//      }, receiveValue: receiveValue)
//  }
//
//  func sink<T: Decodable>(_ type: T.Type, receiveValue: @escaping ((T) -> Void)) -> AnyCancellable {
//    return
//      self.map1(type)
//      .receive(on: DispatchQueue.main)
//      .sink(receiveCompletion: { (completion) in
//        switch completion {
//        case .finished:
//          _ = self.print("request finished")
//        case .failure(let error):
//          _ = self.print(error.localizedDescription)
//        }
//      }, receiveValue: receiveValue)
//  }
//}


//extension Publishers.TryMap where Output == Decodable {
//  func sink(receiveValue: @escaping ((Decodable) -> Void)) -> AnyCancellable{
//    return self.receive(on: DispatchQueue.main)
//      .sink(receiveCompletion: { (completion) in
//        switch completion {
//        case .finished:
//          _ = self.print("request finished")
//        case .failure(let error):
//          _ = self.print(error.localizedDescription)
//        }
//      }, receiveValue: receiveValue)
//  }
//}

