//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Ivan Kulundzic on 14/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class HomeViewModelTests: XCTestCase {
  func testRateCalculation() {
    // Arrange
    let viewModel = HomeViewModel()
    viewModel.currencyFrom = Currency(buyingRate: "4.596262", currencyCode: "AUD", medianRate: "4.610092", sellingRate: "4.623922", unitValue: 1)
    viewModel.currencyTo = Currency(buyingRate: "4.853077", currencyCode: "CAD", medianRate: "4.867680", sellingRate: "4.882283", unitValue: 1)
    
    // Assertion
    viewModel.resultChangedHandler = { result in
      let expected = "1 AUD = 0.952782 CAD"
      XCTAssert(result == expected, "\(String(describing: result)) is not what we expect: \"\("1 AUD = 0.952782 CAD")\"")
    }
    
    // Act
    viewModel.calculateRates()
  }
}
