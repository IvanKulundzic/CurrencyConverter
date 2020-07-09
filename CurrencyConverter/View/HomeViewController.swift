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
    handleActions()
  }
}

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

// MARK: - add viewModel as data source and delegate for the pickers
private extension HomeViewController {
  func setupPickersViewDataSourceAndDelegate() {
    homeView.currencyFromPicker.dataSource = homeViewModel
    homeView.currencyFromPicker.delegate = self
    homeView.currencyToPicker.dataSource = homeViewModel
    homeView.currencyToPicker.delegate = self
  }
}













//// MARK: - PickerView delegate
//extension HomeViewController: UIPickerViewDelegate {
//    func declareHomeViewDelegatesAndDataSource() {
////        homeView.currencyFromPicker.delegate = self
////        homeView.currencyToPicker.delegate = self
////        homeView.currencyFromPicker.dataSource = self
////        homeView.currencyToPicker.dataSource = self
//    }
//}
//
//// MARK: - PickerView datasource
//extension HomeViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerDataSource.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerDataSource[row]
//    }
//}

// MARK: - Get currency data
//private extension HomeViewController {
//    func loadCurrencyData() {
//        networkingManager.getCurrencyData {[weak self] currencies in
//            guard let strongSelf = self else { return }
//            strongSelf.currencies = currencies
//        }
//    }
//}

// MARK: - HomeViewSumbitButton tapped
//private extension HomeViewController {
//    func homeViewButtonTapped() {
//        homeView.actionHandler = { [weak self] in
//            guard let strongSelf = self else { return }
//            let value1 = strongSelf.homeView.currencyFromPicker.selectedRow(inComponent: 0)
//            let value2 = strongSelf.homeView.currencyToPicker.selectedRow(inComponent: 0)
//            let selectedCurrency = strongSelf.currencies[value1]
//            let desiredCurrency = strongSelf.currencies[value2]
//            let firstCurrency = Double(selectedCurrency.buyingRate)
//            let firstCurrencyUnitCount = Double(selectedCurrency.unitValue)
//            let secondCurrency = Double(desiredCurrency.buyingRate)
//            let secondCurrencyUnitCount = Double(desiredCurrency.unitValue)
//            let selectedCur = Double(strongSelf.currencies[value1].sellingRate)
//            let desiredCur = Double(strongSelf.currencies[value2].sellingRate)
//            var result: Double
//            var sellingRateResult: Double
//            guard let firstCur = firstCurrency, let secondCur = secondCurrency else { return }
//            guard let sellingRateSelectedCurrency = selectedCur, let sellingRateDesiredCurrency = desiredCur else { return }
//            if firstCurrencyUnitCount == 1 {
//                result = (Double(firstCur) / Double(firstCurrencyUnitCount)) / (Double(secondCur) / Double(secondCurrencyUnitCount))
//                sellingRateResult = (Double(sellingRateSelectedCurrency)) / Double(firstCurrencyUnitCount) / (Double(sellingRateDesiredCurrency) / Double(secondCurrencyUnitCount))
//                strongSelf.homeView.resultLabel.text = "Buying rate: \(result) \nSelling rate: \(sellingRateResult)"
//            } else if firstCurrencyUnitCount > 1 {
//                result = (Double(firstCur) / Double(firstCurrencyUnitCount)) * 100 / (Double(secondCur) / Double(secondCurrencyUnitCount))
//                sellingRateResult = (Double(sellingRateSelectedCurrency)) / Double(firstCurrencyUnitCount) * 100 / (Double(sellingRateDesiredCurrency) / Double(secondCurrencyUnitCount))
//                strongSelf.homeView.resultLabel.text = "Buying rate: \(result) \nSelling rate: \(sellingRateResult)"
//            }
//        }
//    }
//}
