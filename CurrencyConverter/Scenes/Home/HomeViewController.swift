//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
  private lazy var homeView = HomeView()
  private var viewModel: HomeViewModelProtocol
  
  init(viewModel: HomeViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = homeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHomeView()
    setupViewModelBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.getCurrencyCoversionRates()
  }
}

// MARK: - picker(s) delegate methods
extension HomeViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == homeView.currencyFromPicker {
      let currencyFrom = viewModel.currencies[row]
      viewModel.currencyFrom = currencyFrom
    } else if pickerView == homeView.currencyToPicker {
      let currencyTo = viewModel.currencies[row]
      viewModel.currencyTo = currencyTo
  }
}
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    viewModel.currencies[row].currencyCode
  }
}

// MARK: - handle actions
private extension HomeViewController {
  func setupHomeView() {
    homeView.currencyFromPicker.dataSource = viewModel
    homeView.currencyFromPicker.delegate = self
    homeView.currencyToPicker.dataSource = viewModel
    homeView.currencyToPicker.delegate = self
    homeView.actionHandler = { [weak self] in
      self?.viewModel.calculateRates()
    }
  }
  
  func setupViewModelBindings() {
    viewModel.currenciesChangedHandler = { [weak self] in
      self?.updateUI()
    }
    
    viewModel.isLoadingChangedHandler = { [weak self] isLoading in
      isLoading ? self?.homeView.activityIndicator.startAnimating() :
        self?.homeView.activityIndicator.stopAnimating()
    }
    
    viewModel.resultChangedHandler = { [weak self] result in
      self?.homeView.result = result
    }
  }
}

// MARK: - update homeView UI with model data
private extension HomeViewController {
  func updateUI() {
    homeView.result = viewModel.result
    homeView.currencyFromPicker.reloadAllComponents()
    homeView.currencyToPicker.reloadAllComponents()
    homeView.activityIndicator.stopAnimating()
  }
}
