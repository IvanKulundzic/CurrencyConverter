//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: UIPickerViewDataSource {
  var currencies: [Currency] { get }
  var currencyFrom: Currency? { get set }
  var currencyTo: Currency? { get set }
  var result: String? { get set }
  var currenciesChangedHandler: Action? { get set }
  var resultChangedHandler: TypedAction<String?>? { get set }
  var isLoadingChangedHandler: TypedAction<Bool>? { get set }
  func getCurrencyCoversionRates()
  func calculateRates()
}

final class HomeViewModel: NSObject, HomeViewModelProtocol {
  var currenciesChangedHandler: Action?
  var resultChangedHandler: TypedAction<String?>?
  var isLoadingChangedHandler: TypedAction<Bool>?
  
  var currencies: [Currency] {
    didSet {
        currenciesChangedHandler?()
    }
  }
  
  var result: String? {
    didSet {
      resultChangedHandler?(result)
    }
  }
  
  var currencyFrom: Currency?
  var currencyTo: Currency?
  
  init(currencies: [Currency] = []) {
    self.currencies = currencies
  }
}

// MARK: - get currency data
/// method does an API call, parses the response and sets the viewModel variable currency
extension HomeViewModel {
  func getCurrencyCoversionRates() {
    isLoadingChangedHandler?(true)
    
    let networkingManager = NetworkingManager()
    let urlToUse = "http://hnbex.eu/api/v1/rates/daily/"
    if let url = URL(string: urlToUse) {
      networkingManager.getApiData(url: url) { [weak self] (result: Result<[Currency], Error>) in
        switch result {
        case .success(let currencies):
          self?.currencies = currencies
          self?.currencyFrom = currencies[0]
          self?.currencyTo = currencies[0]
        case .failure(let error):
          print(error.localizedDescription)
        }
        self?.isLoadingChangedHandler?(false)
      }
    }
  }
  
  func calculateRates() {
    guard
      let currencyFromCode = currencyFrom?.currencyCode,
      let currencyToCode = currencyTo?.currencyCode,
      let currencyFromRate = currencyFrom?.sellingRate.toDouble(),
      let currencyToRate = currencyTo?.buyingRate.toDouble(),
      let currencyFromUnit = currencyFrom?.unitValue,
      let currencyToUnit = currencyTo?.unitValue
    else {
      return
    }
    
    let conversionResult = ((currencyFromRate / currencyToRate) * Double(currencyToUnit)).rounded(toPlaces: 6)
    let resultString = "\(currencyFromUnit) \(currencyFromCode) = \(conversionResult) \(currencyToCode)"
    result = resultString
  }
}

// MARK: - viewModel is the pickerView(s) data source
/// Both pickers share the same data, thus not differentiating them
extension HomeViewModel: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    currencies.count
  }
}
