//
//  JSONParser.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation

struct JsonParser {
  func parseJson<T: Codable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
    
//    do {
//      let jsonObject = try decoder.decode(T.self, from: data)
//      json = jsonObject
//      
//    } catch {
//      print("Error parsing JSON: ", error)
//    }
//    return json
////    return try decoder.decode(T.self, from: data)
  }
}
