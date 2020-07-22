//
//  EnumAPIErrors.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 21/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation

enum APIErrors: Error {
  case badRequest
  case serviceUnavailable
  case internalServerError
}
