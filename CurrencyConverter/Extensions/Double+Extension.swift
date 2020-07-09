//
//  Double+Extension.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 09/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
