//
//  IRest+Extension.swift
//  Alamofire+Combine+SwiftUI
//
//  Created by Tema.Tian on 2020/5/18.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

// MARK: - Alamofire Bridge extension suppurt
public typealias Method = Alamofire.HTTPMethod
public typealias URLRequestConvertible = Alamofire.URLRequestConvertible
public typealias Parameters = Alamofire.Parameters
public typealias URLEncoding = Alamofire.URLEncoding
public typealias JSON = SwiftyJSON.JSON
public typealias Future = Combine.Future


// MARK: - JSON extension suppurt
extension JSON {
  /// 返回[T]
  /// - 描述: 将response转换为[T]
  public func decodeObject<T: Decodable>(_ type: T.Type) throws -> T {
    guard let object = try? JSONDecoder().decode(type, from: rawData()) else {
      throw RestError.error(error: "map json to Codable Model failed")
    }
    return object
  }
  
  /// 返回[T]
  /// - 描述: 将response转换为[T]
  public func decodeArray<T: Decodable>(_ type: T.Type) throws -> [T] {
    guard let array = try? JSONDecoder().decode([T].self, from: rawData()) else {
      throw RestError.error(error: "map json to Codable List failed")
    }
    return array
  }
  
  public func mapJSONForKey(_ key: String) -> JSON {
    if key.contains(".") {
      let keys = key.components(separatedBy: ".")
      var json = self
      for k in keys {
        json = json[k]
      }
      return json
    }
    return self[key]
  }
}

// MARK: - Future Output -> JSON, Failure -> RestError extension suppurt
extension Future where Output == JSON, Failure == RestError {
  
  func tryMapObject<T: Decodable>(_ type: T.Type) -> Publishers.TryMap<Future<JSON, RestError>, T> {
    let s = self.tryMap { (json) -> T in
      do {
        return try json.decodeObject(type)
      } catch {
        throw RestError.error(error: "try map json to Codable Object failed")
      }
    }
    return s
  }
  
  func tryMapArray<T: Decodable>(_ type: T.Type) -> Publishers.TryMap<Future<JSON, RestError>, [T]> {
    let s = self.tryMap { (json) -> [T] in
      do {
        return try json.decodeArray(type)
      } catch {
        throw RestError.error(error: "try map json to Codable List failed")
      }
    }
    return s
  }
  
  func mapObject<T: Decodable>(_ type: T.Type) -> Publishers.Map<Future<JSON, RestError>, T> {
    let map = self.map({ (json) -> T in
      return try! json.decodeObject(type)
    })
    return map
  }
  
  func mapArray<T: Decodable>(_ type: T.Type) -> Publishers.Map<Future<JSON, RestError>, [T]> {
    let map = self.map({ (json) -> [T] in
      return (try? json.decodeArray(type)) ?? []
    })
    return map
  }
  
  func sinkObject<T: Decodable>(_ type: T.Type, receiveValue: @escaping ((T) -> Void)) -> AnyCancellable {
    return
      self.tryMapObject(type)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { (completion) in
          switch completion {
          case .finished:
            _ = self.print("request finished")
          case .failure(let error):
            _ = self.print(error.localizedDescription)
          }
        }, receiveValue: receiveValue)
  }
  
  func sinkArray<T: Decodable>(_ type: T.Type, receiveValue: @escaping (([T]) -> Void)) -> AnyCancellable {
    return
      self.tryMapArray(type)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { (completion) in
          switch completion {
          case .finished:
            _ = self.print("request finished")
          case .failure(let error):
            _ = self.print(error.localizedDescription)
          }
        }, receiveValue: receiveValue)
  }
}

extension Dictionary {
  mutating func merge(_ dict: [Key: Value]) {
    self.merge(dict) { (_, new) in new }
  }
}

