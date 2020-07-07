//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
import UIKit

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
        self?.currencies = currencies
      }
    }
  }
}

extension HomeViewModel: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    5
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    "CRO"
  
    
  }
}
