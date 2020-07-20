//
//  NetworkingController.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import Foundation

final class NetworkingManager {
  func getApiData<T: Codable>(url: URL, completion: @escaping CompletionHandler<Result<T, Error>>) {
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      DispatchQueue.main.async {
        if let error = error {
          print("Failed to get data from url: ", error)
          completion(.failure(error))
          return
        }
        
        guard let data = data else {
          #warning("TODO: Add networking errors")
//          completion(.failure(Error))
          return
        }
        
        do {
          let object: T = try JsonParser().parseJson(data: data)
          completion(.success(object))
        } catch {
          print("Error parsing JSON: ", error)
          completion(.failure(error))
        }
      }
    }.resume()
  }
}
