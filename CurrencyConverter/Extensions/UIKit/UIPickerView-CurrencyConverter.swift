//
//  UIPickerView+extension.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 09/07/2020.
//  Copyright © 2020 Ivan Kulundzic. All rights reserved.
//

import Foundation
import UIKit

extension UIPickerView {
  static func pickerView() -> UIPickerView {
    let pickerView = UIPickerView()
    /// Picker visual setup
    pickerView.backgroundColor = .clear
    pickerView.layer.borderWidth = 1.0
    pickerView.layer.borderColor = UIColor.systemGray.cgColor
    pickerView.layer.cornerRadius = 20.0
    return pickerView
  }
}
