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
    private lazy var topLabel = UILabel()
    private lazy var midLabel = UILabel()
    private lazy var resultLabel = UILabel()
    private lazy var currencyFromPicker = UIPickerView()
    private lazy var currencyToPicker = UIPickerView()
    
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
}

// MARK: - setup view
private extension HomeView {
    func setupView() {
        
    }
}

// MARK: - Submit button tapped
extension HomeView {
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        actionHandler?()
    }
}
