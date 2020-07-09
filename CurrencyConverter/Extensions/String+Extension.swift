//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 09/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
