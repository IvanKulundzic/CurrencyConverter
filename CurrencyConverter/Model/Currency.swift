//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let code: String
    let unitValue: Int
    let buyingRate: String
    let medianRate: String
    let sellingRate: String
    
    enum CodingKeys: String, CodingKey {
        case code = "currency_code"
        case unitValue = "unit_value"
        case buyingRate = "buying_rate"
        case medianRate = "median_rate"
        case sellingRate = "selling_rate"
    }
}
