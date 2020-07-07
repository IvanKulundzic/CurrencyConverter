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
  var currencies: [Currency]? {
    didSet {
        debugPrint(currencyCode)
        homeViewModelAction?()      
    }
  }
  
  init(currencies: [Currency]? = nil) {
    self.currencies = currencies
  }
}

// MARK: - viewModel properties
extension HomeViewModel {
  var currencyCode: String? {
//    print(currencies?.first)
    return currencies?.first?.currencyCode
  }
}

// MARK: - get currency data
/// method does an API call, parses the response and sets the viewModel variable currency
extension HomeViewModel {
  func getCurrencyCoversionRates() {
    let networkingManager = NetworkingManager()
    let urlToUse = "http://hnbex.eu/api/v1/rates/daily/"
    if let url = URL(string: urlToUse) {
      networkingManager.getApiData(url: url) { [weak self] (currencies: [Currency]) in
//        print("json: \(currencies)")
        self?.currencies = currencies
//        print("ViewModel currency object: ", self?.currencies)
      }
    }
  }
}
