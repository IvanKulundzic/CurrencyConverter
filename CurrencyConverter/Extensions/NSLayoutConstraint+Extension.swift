//
//  NSLayoutConstraint+Extension.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 07/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
import UIKit

/// Activate constraints and set translatesAutoresizingMaskIntoConstraints to false with each new UIView
extension NSLayoutConstraint {
  public class func useAndActivateConstraints(constraints: [NSLayoutConstraint]) {
    for constraint in constraints {
      if let view = constraint.firstItem as? UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
      }
    }
    activate(constraints)
  }
}
