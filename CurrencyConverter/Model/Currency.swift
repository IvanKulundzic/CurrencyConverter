//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import Foundation
import CoreData

struct Currency: Codable, Equatable {
  let buyingRate: String
  let currencyCode: String
  let medianRate: String
  let sellingRate: String
  let unitValue: Int
}

class CurrencyCoreData: NSManagedObject {
  @NSManaged var buyingRate: String
  @NSManaged var currencyCode: String
  @NSManaged var medianRate: String
  @NSManaged var sellingRate: String
  @NSManaged var unitValue: Int
}
