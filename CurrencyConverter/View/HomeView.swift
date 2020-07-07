//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import UIKit

final class HomeView: UIView {
  var actionHandler: Action?
  private lazy var topLabel = UILabel()
  private lazy var midLabel = UILabel()
  private lazy var resultLabel = UILabel()
  private(set) lazy var currencyFromPicker = UIPickerView()
  private(set) lazy var currencyToPicker = UIPickerView()
  private lazy var submitButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: - view properties
/// exposing view properties in order to update the UI based on viewModel data
extension HomeView {
  var result: String? {
    get { resultLabel.text }
    set { resultLabel.text = newValue }
  }
}

// MARK: - setup view
private extension HomeView {
  /// Main setup method that is used as a method caller for all other UI components setup methods
  func setupView() {
    backgroundColor = .white
    setupTopLabel()
    setupCurrencyFromPicker()
    setupMidLabel()
    setupCurrencyToPicker()
    setupResultLabel()
    setupSubmitButton()
  }
  
  func setupTopLabel() {
    addSubview(topLabel)
    let topLabelConstraints = [
      topLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      topLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
      topLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
      topLabel.heightAnchor.constraint(equalToConstant: 60)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: topLabelConstraints)
    topLabel.backgroundColor = .clear
    topLabel.text = "Choose a currency to convert FROM"
    topLabel.textAlignment = .center
    topLabel.font = UIFont.systemFont(ofSize: 20)
  }
  
  func setupCurrencyFromPicker() {
    addSubview(currencyFromPicker)
    let currencyFromPickerConstraints = [
      currencyFromPicker.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 2),
      currencyFromPicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      currencyFromPicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      currencyFromPicker.heightAnchor.constraint(equalToConstant: 200)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: currencyFromPickerConstraints)
    currencyFromPicker.backgroundColor = .blue
  }
  
  func setupMidLabel() {
    addSubview(midLabel)
    let midLabelConstraints = [
      midLabel.topAnchor.constraint(equalTo: currencyFromPicker.bottomAnchor, constant: 5),
      midLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      midLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      midLabel.heightAnchor.constraint(equalToConstant: 60)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: midLabelConstraints)
    midLabel.backgroundColor = .clear
    midLabel.text = "Choose a currency to convert TO"
    midLabel.textAlignment = .center
    midLabel.font = UIFont.systemFont(ofSize: 20)
  }
  
  func setupCurrencyToPicker() {
    addSubview(currencyToPicker)
    let currencyToPickerConstraints = [
      currencyToPicker.topAnchor.constraint(equalTo: midLabel.bottomAnchor, constant: 2),
      currencyToPicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      currencyToPicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      currencyToPicker.heightAnchor.constraint(equalToConstant: 200)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: currencyToPickerConstraints)
    currencyToPicker.backgroundColor = .blue
  }
  
  func setupResultLabel() {
    addSubview(resultLabel)
    let resultLabelConstraints = [
      resultLabel.topAnchor.constraint(equalTo: currencyToPicker.bottomAnchor, constant: 10),
      resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      resultLabel.heightAnchor.constraint(equalToConstant: 100)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: resultLabelConstraints)
    resultLabel.backgroundColor = .red
    resultLabel.text = "Result label"
    resultLabel.textAlignment = .center
    resultLabel.font = UIFont.systemFont(ofSize: 20)
  }
  
  func setupSubmitButton() {
    addSubview(submitButton)
    let submitButtonConstraints = [
      submitButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
      submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      submitButton.heightAnchor.constraint(equalToConstant: 60),
      submitButton.widthAnchor.constraint(equalToConstant: 100)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: submitButtonConstraints)
    submitButton.backgroundColor = .systemPink
    submitButton.setTitle("Submit", for: .normal)
    
    submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
  }
}

// MARK: - submit button tapped
extension HomeView {
  @objc func submitButtonTapped() {
    actionHandler?()
  }
}
