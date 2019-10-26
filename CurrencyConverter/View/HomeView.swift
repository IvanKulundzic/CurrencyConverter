//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import UIKit

typealias Action = () -> Void

class HomeView: UIView {
    var actionHandler: Action?
    @IBOutlet weak var currencyFromPicker: UIPickerView!
    @IBOutlet weak var currencyToPicker: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet private weak var currencyFromLabel: UILabel!
    @IBOutlet private weak var currencyToLabel: UILabel!
}

// MARK: - Submit button tapped
extension HomeView {
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        actionHandler?()
    }
}
