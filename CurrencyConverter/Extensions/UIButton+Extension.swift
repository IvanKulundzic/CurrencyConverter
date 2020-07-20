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
    let title = NSLocalizedString("home_view_submit_button_title", comment: "")
    button.setTitle(title, for: .normal)
    /// Add shadow to the button
    button.layer.shadowOffset = .zero
    button.layer.shadowRadius = 5.0
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.8
    return button
  }
}
