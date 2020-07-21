//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 09/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
/// Convinience method to convert a string to double
extension String {
  func toDouble() -> Double? {
    return NumberFormatter().number(from: self)?.doubleValue
  }
}
