//
//  TypeAlias.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
/// Communication action handler - i.e. button tapped
public typealias Action = () -> Void
/// Completion handler that takes a generic parameter - i.e. networking closure
public typealias TypedAction<T> = (T) -> Void
