//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class HomeViewModel: NSObject {
  var homeViewModelAction: Action?
  var currencies: [Currency]? {
    didSet {
        homeViewModelAction?()
        createPList()
    }
  }
  var currencyFrom: Currency?
  var currencyTo: Currency?
  var result: String?
  
  init(currencies: [Currency]? = nil) {
    self.currencies = currencies
  }
}

// MARK: - viewModel properties
//extension HomeViewModel {
//  var currencyCode: String? {
//    currencies?.first?.currencyCode
//  }
//}

// MARK: - get currency data
/// method does an API call, parses the response and sets the viewModel variable currency
extension HomeViewModel {
  func getCurrencyCoversionRates() {
    let networkingManager = NetworkingManager()
    let urlToUse = "http://hnbex.eu/api/v1/rates/daily/"
    if let url = URL(string: urlToUse) {
      networkingManager.getApiData(url: url) { [weak self] (currencies: [Currency]) in
        self?.currencies = currencies
        print("1. Count: \(String(describing: self?.currencies?.count))")
        //print("2. Currencies codes: \(self?.currencyCode)")
      }
    }
  }
}

// MARK: - viewModel is the pickerView(s) data source
/// Both pickers share the same data, thus not differentiating them
extension HomeViewModel: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    currencies?.count ?? 10
  }
}

// MARK: - method for calculating conversion rates
/// Method uses selected currencies (from - to) and calculates the conversion from selected to desired currency
extension HomeViewModel {
  func calculateRates() {
    guard
      let currencyFromCode = currencyFrom?.currencyCode,
      let currencyToCode = currencyTo?.currencyCode,
      let currencyFromRate = currencyFrom?.sellingRate.toDouble(),
      let currencyToRate = currencyTo?.buyingRate.toDouble(),
      let currencyFromUnit = currencyFrom?.unitValue,
      let currencyToUnit = currencyTo?.unitValue
    else { return }
    
    let conversionResult = ((currencyFromRate / currencyToRate) * Double(currencyToUnit)).rounded(toPlaces: 6)
    let resultString = "\(currencyFromUnit) \(currencyFromCode) = \(conversionResult) \(currencyToCode)"
    result = resultString
  }
}

// MARK: - create plist for testing purposes
extension HomeViewModel {
  func createPList() {
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Currencies.plist")
    do {
      let data = try encoder.encode(currencies)
      print("2. Data:", data)
      try data.write(to: path)
      print("3. Path: \(path)")
    } catch {
      print(error)
    }
    print(#function)
  }
}
