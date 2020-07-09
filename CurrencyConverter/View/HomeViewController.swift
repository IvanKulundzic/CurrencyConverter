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
  private let homeViewModel = HomeViewModel()
  
  override func loadView() {
    view = homeView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    homeView.activityIndicator.startAnimating()
    setupPickersViewDataSourceAndDelegate()
    homeViewModel.getCurrencyCoversionRates()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homeView.activityIndicator.stopAnimating()
    handleActions()
  }
}

// MARK: - picker(s) delegate methods
extension HomeViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == homeView.currencyFromPicker {
      if let currencyFrom = homeViewModel.currencies?[row] {
        homeViewModel.currencyFrom = currencyFrom
      }
    } else if pickerView == homeView.currencyToPicker {
      if let currencyTo = homeViewModel.currencies?[row] {
        homeViewModel.currencyTo = currencyTo
      }
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    homeViewModel.currencies?[row].currencyCode
  }
}

// MARK: - handle actions
private extension HomeViewController {
  /// Main caller method to for handling all action handlers
  func handleActions() {
    homeViewSubmitButtonTapped()
    homeViewModelAction()
  }
  /// HomeView submit button tapped action
  func homeViewSubmitButtonTapped() {
    homeView.actionHandler = { [weak self] in
      self?.homeViewModel.calculateRates()
      self?.updateUI()
    }
  }
  /// HomeViewModel action that is called when homeViewModel variable currency is set
  /// This method calls the updateUI method in order to update the homeView UI based on viewModel data
  func homeViewModelAction() {
    homeViewModel.homeViewModelAction = { [weak self] in
      self?.updateUI()
    }
  }
}

// MARK: - update homeView UI with model data
private extension HomeViewController {
  func updateUI() {
    homeView.result = homeViewModel.result
    homeView.currencyFromPicker.reloadAllComponents()
    homeView.currencyToPicker.reloadAllComponents()
    homeView.activityIndicator.stopAnimating()
  }
}

// MARK: - add viewModel as data source and viewController as delegate for the pickers
private extension HomeViewController {
  func setupPickersViewDataSourceAndDelegate() {
    homeView.currencyFromPicker.dataSource = homeViewModel
    homeView.currencyFromPicker.delegate = self
    homeView.currencyToPicker.dataSource = homeViewModel
    homeView.currencyToPicker.delegate = self
  }
}
