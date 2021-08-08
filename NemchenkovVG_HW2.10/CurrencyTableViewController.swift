//
//  CurrencyTableViewController.swift
//  NemchenkovVG_HW2.10
//
//  Created by Владимир Немченков on 08.08.2021.
//

import UIKit

class CurrencyTableViewController: UITableViewController {

    private var data: [CurrencyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrency()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell
        
        let currency = data[indexPath.row]
        
        cell.currencyInfoLabel.text = """
            Date: \(currency.date ?? "0")
            Previous date \(currency.previousDate ?? "0")
            Timestamp \(currency.timestamp ?? "0")
            Valute \(currency.valute)
            """
        
        
        
        return cell
    }
}

//extension CurrencyTableViewController {
//    private func getCurrency() {
//        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, let response = response else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//        }.resume()
//    }
//}

extension CurrencyTableViewController {
    func fetchCurrency() {
        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error descriprion")
                return
            }
            
           
            do {
                self.data = try JSONDecoder().decode([CurrencyModel].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    }
