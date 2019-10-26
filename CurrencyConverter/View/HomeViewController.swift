//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ivan Kulundzic on 26/10/2019.
//  Copyright © 2019 Ivan Kulundzic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var homeView: HomeView!
    var currencies: [Currency] = []
    var pickerDataSource = ["AUD", "CAD", "CZK", "DKK", "HUF", "JPY", "NOK", "SEK", "CHF", "GBP", "USD", "BAM", "EUR", "PLN"]
    var selectedCurrency = ""
    var desiredCurrency = ""
    var result = ""
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencyData { currencies in
            self.currencies = currencies
        }
        
        homeView.currencyFromPicker.delegate = self
        homeView.currencyToPicker.delegate = self
        homeView.currencyFromPicker.dataSource = self
        homeView.currencyToPicker.dataSource = self
        
        print(currencies)
        
        homeViewButtonTapped()
        
    }
    
    
        func homeViewButtonTapped() {
            homeView.actionHandler = { [weak self] in
                guard let strongSelf = self else { return }
                
                let value1 = strongSelf.homeView.currencyFromPicker.selectedRow(inComponent: 0)
                let value2 = strongSelf.homeView.currencyToPicker.selectedRow(inComponent: 0)
                
                let selectedCurrency = strongSelf.currencies[value1]
                let desiredCurrency = strongSelf.currencies[value2]
                
                
                let firstCurrency = Double(selectedCurrency.buyingRate)
                let firstCurrencyUnitCount = Double(selectedCurrency.unitValue)
                
                
                let secondCurrency = Double(desiredCurrency.buyingRate)
                let secondCurrencyUnitCount = Double(desiredCurrency.unitValue)
                
                
                let selectedCur = Double(strongSelf.currencies[value1].sellingRate)
                let desiredCur = Double(strongSelf.currencies[value2].sellingRate)
                
                var result: Double
                var sellingRateResult: Double
                if firstCurrencyUnitCount == 1 {
                    result = (Double(firstCurrency!) / Double(firstCurrencyUnitCount)) / (Double(secondCurrency!) / Double(secondCurrencyUnitCount))
                    print(result)
                    
                    sellingRateResult = (Double(selectedCur!)) / Double(firstCurrencyUnitCount) / (Double(desiredCur!) / Double(secondCurrencyUnitCount))
                    
                    strongSelf.homeView.resultLabel.text = "Buying rate: \(result) \nSelling rate: \(sellingRateResult)"
                } else if firstCurrencyUnitCount > 1 {
                    result = (Double(firstCurrency!) / Double(firstCurrencyUnitCount)) * 100 / (Double(secondCurrency!) / Double(secondCurrencyUnitCount))
                    print(result)
                    sellingRateResult = (Double(selectedCur!)) / Double(firstCurrencyUnitCount) * 100 / (Double(desiredCur!) * Double(secondCurrencyUnitCount))
                    strongSelf.homeView.resultLabel.text = "Buying rate: \(result) \nSelling rate: \(sellingRateResult)"
                }
                
                
                
                               
                
                
               
                
                
                
                
            }
        }
    
    func getCurrencyData(completion: @escaping (([Currency]) -> Void)) {
        guard let url = URL(string: "http://hnbex.eu/api/v1/rates/daily") else { return }
        let request = URLRequest(url:url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to get data from url:", error)
                    return
                }
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let jsonObject = try decoder.decode([Currency].self, from: data)
                    completion(jsonObject)
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }.resume()
    }
}

// MARK: - Picker delegate
extension HomeViewController: UIPickerViewDelegate {
    
}

// MARK: - Picker datasource
extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == homeView.currencyFromPicker {
            selectedCurrency = pickerDataSource[pickerView.selectedRow(inComponent: 0)]
        } else if pickerView == homeView.currencyToPicker {
            desiredCurrency = pickerDataSource[pickerView.selectedRow(inComponent: 0)]
            print("New currency: \(desiredCurrency)")
        } else {
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
}
