//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import Foundation
import CoreData

struct Currency: Codable {
  let buyingRate: String
  let currencyCode: String
  let medianRate: String
  let sellingRate: String
  let unitValue: Int
  
  enum CodingKeys: String, CodingKey {
    case buyingRate = "buying_rate"
    case currencyCode = "currency_code"
    case medianRate = "median_rate"
    case sellingRate = "selling_rate"
    case unitValue = "unit_value"
  }
}
