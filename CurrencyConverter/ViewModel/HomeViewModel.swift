//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation

final class HomeViewModel: NSObject {
  var homeViewModelAction: Action?
  var currency: [Currency]? {
    didSet {
        homeViewModelAction?()      
    }
  }
  
  init(currency: [Currency]? = nil) {
    self.currency = currency
  }
}

// MARK: - viewModel properties
//extension HomeViewModel {
//  var currencyCode: String? {
//    return currency
//  }
//}

// MARK: - get currency data
/// method does an API call, parses the response and sets the viewModel variable currency
extension HomeViewModel {
  func getCurrencyCoversionRates() {
    let networkingManager = NetworkingManager()
    let urlToUse = "http://hnbex.eu/api/v1/rates/daily/"
    if let url = URL(string: urlToUse) {
      networkingManager.getApiData(url: url) { [weak self] (currency) in
        print("json: \(currency)")
        self?.currency = currency
//        print("ViewModel currency object: ", self?.currency)
      }
    }
  }
}
