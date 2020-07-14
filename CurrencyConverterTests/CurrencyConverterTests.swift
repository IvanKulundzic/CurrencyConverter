//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Ivan Kulundzic on 14/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {
  var sut: HomeViewModel!
  
  override func setUp() {
    super.setUp()
    sut = HomeViewModel()
    //sut.getCurrencyCoversionRates()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
   func testViewModelCurrencyIsNilAtStart() {
    let currencies = sut.currencies
    XCTAssertEqual(currencies?.count, nil)
   }
  
  func testViewModelMakesASuccessfulAPICall() {
    sut.getCurrencyCoversionRates()
    guard let count = sut.currencies?.count else { return }
    XCTAssertGreaterThan(count, 0)
  }
  
  func testViewModelGetRates() {
    sut.getCurrencyCoversionRates()
    XCTAssertNil(sut.currencies?.first?.currencyCode, "AUD")
  }
}
