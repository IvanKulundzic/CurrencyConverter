//
//  UIButton+Extension.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 08/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
  static func submitButton() -> UIButton {
    let button = UIButton()
    /// Button visual setup
    button.backgroundColor = .systemPink
    button.setTitle("Submit", for: .normal)
    //button.layer.cornerRadius = button.frame.height / 2
    /// Add shadow to the button
    button.layer.shadowOffset = .init(width: 0, height: 0)
    button.layer.shadowRadius = 5.0
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.8
    return button
  }
}
