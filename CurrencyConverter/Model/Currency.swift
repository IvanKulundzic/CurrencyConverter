//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import Foundation

struct Currency: Codable {
  let buyingRate: String
  let currencyCode: String
  let medianRate: String
  let sellingRate: String
  let unitValue: Int
}
