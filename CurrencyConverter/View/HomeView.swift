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
  private(set) lazy var currencyFromPicker = UIPickerView.pickerView()
  private(set) lazy var currencyToPicker = UIPickerView.pickerView()
  private(set) lazy var activityIndicator = UIActivityIndicatorView()
  private lazy var topLabel = UILabel()
  private lazy var midLabel = UILabel()
  private lazy var resultLabel = UILabel()
  private lazy var submitButton = UIButton.submitButton()
  
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

// MARK: - submit button tapped
extension HomeView {
  @objc func submitButtonTapped() {
    actionHandler?()
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
    setupActivityIndicator()
  }
  
  func setupTopLabel() {
    addSubview(topLabel)
    let topLabelConstraints = [
      topLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      topLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
      topLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
      topLabel.heightAnchor.constraint(equalToConstant: 50)
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
      currencyFromPicker.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 1),
      currencyFromPicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      currencyFromPicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      currencyFromPicker.heightAnchor.constraint(equalToConstant: 200)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: currencyFromPickerConstraints)
  }
  
  func setupMidLabel() {
    addSubview(midLabel)
    let midLabelConstraints = [
      midLabel.topAnchor.constraint(equalTo: currencyFromPicker.bottomAnchor, constant: 5),
      midLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      midLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      midLabel.heightAnchor.constraint(equalToConstant: 50)
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
      currencyToPicker.topAnchor.constraint(equalTo: midLabel.bottomAnchor, constant: 1),
      currencyToPicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      currencyToPicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      currencyToPicker.heightAnchor.constraint(equalToConstant: 200)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: currencyToPickerConstraints)
  }
  
  func setupResultLabel() {
    addSubview(resultLabel)
    let resultLabelConstraints = [
      resultLabel.topAnchor.constraint(equalTo: currencyToPicker.bottomAnchor, constant: 10),
      resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      resultLabel.heightAnchor.constraint(equalToConstant: 100)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: resultLabelConstraints)
    resultLabel.backgroundColor = .clear
    resultLabel.textAlignment = .center
    resultLabel.font = UIFont.systemFont(ofSize: 25)
    
    resultLabel.layer.borderWidth = 1.0
    resultLabel.layer.borderColor = UIColor.systemGray.cgColor
    resultLabel.layer.cornerRadius = 20.0
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
    
    submitButton.layer.cornerRadius = 20
    submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
  }
  
  func setupActivityIndicator() {
    addSubview(activityIndicator)
    let activityIndicatorConstraints = [
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
      activityIndicator.heightAnchor.constraint(equalToConstant: 30),
      activityIndicator.widthAnchor.constraint(equalToConstant: 30)
    ]
    NSLayoutConstraint.useAndActivateConstraints(constraints: activityIndicatorConstraints)
    activityIndicator.style = .whiteLarge
  }
}
