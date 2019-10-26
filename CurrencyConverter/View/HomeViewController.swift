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
    var currencyArray: [String] = ["EUR", "USD"]
    //var currencyArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.currencyFromPicker.delegate = self
        homeView.currencyToPicker.delegate = self
        getCurrencyData()
        convertCurrency()
    }
    
    func getCurrencyData() {
        guard let requestUrl = URL(string: "http://hnbex.eu/api/v1/rates/daily") else { return }
        let request = URLRequest(url:requestUrl)
        
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
                    print(jsonObject)
                    //print(jsonObject[0].code)
//                    for item in jsonObject {
//                        self.currencyArray.append(item.code)
//                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
            
        }.resume()
    }
    
    func convertCurrency() {
        let currencySelected = homeView.currencyFromPicker
        print(currencySelected)
        
        
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
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
}
