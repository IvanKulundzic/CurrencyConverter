//
//  NetworkingController.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import Foundation

class NetworkingManager {
    func getCurrencyData(completion: @escaping (([Currency]) -> Void)) {
        guard let url = URL(string: "http://hnbex.eu/api/v1/rates/daily") else { return }
        let request = URLRequest(url:url)
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url:", error)
                    return
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let jsonObject = try decoder.decode([Currency].self, from: data)
                    completion(jsonObject)
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }.resume()
    }
}
