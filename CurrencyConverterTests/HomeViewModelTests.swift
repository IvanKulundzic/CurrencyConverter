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
  var sut: HomeViewModel!
  
  override func setUp() {
    super.setUp()
    sut = HomeViewModel()
    sut.getCurrencyCoversionRates()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
   func testViewModelCurrencyIsNilAtStart() {
    let currencies = sut.currencies
    XCTAssertTrue(currencies?.count == nil)
   }
  
  func testViewModelMakesASuccessfulAPICall() {
    guard let count = sut.currencies?.count else { return }
    print("Test count: ", count)
    XCTAssertTrue(count > 0)
  }
  
  func testViewModelCurrenciesCountIsAsExpected() {
    sut.getCurrencyCoversionRates()
    let expectedCount = 5
    guard let curCount = sut.currencies?.count else { return }
    
    XCTAssertEqual(curCount, expectedCount)
  }
  
  func testViewModelGetRates() {
    sut.getCurrencyCoversionRates()
    let expectedCurrency = Currency(buyingRate: "4.596262", currencyCode: "AUD", medianRate: "4.610092", sellingRate: "4.623922", unitValue: 1)
    guard let currency = sut.currencies?.first else { return }
    debugPrint(currency)
    
    waitForExpectations(timeout: 2) { (error) in
      XCTAssertEqual(currency, expectedCurrency)
      print(error)
    }
    
  }
}
