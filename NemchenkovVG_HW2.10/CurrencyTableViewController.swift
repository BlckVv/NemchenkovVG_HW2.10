//
//  CurrencyTableViewController.swift
//  NemchenkovVG_HW2.10
//
//  Created by Владимир Немченков on 08.08.2021.
//

import UIKit

class CurrencyTableViewController: UITableViewController {
    
    private var data: CurrencyModel!
    private var currency: [Valute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrency()
        tableView.rowHeight = 200
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currency.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell
        
        cell.currencyInfoLabel.text = """
            Date: \(data.Date ?? "0")
            Previous date \(data.PreviousDate ?? "0")
            Timestamp \(data.Timestamp ?? "0")
            Valute \(currency[indexPath.row])
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
                self.data = try JSONDecoder().decode(CurrencyModel.self, from: data)
                self.currency = self.data.Valute.map {$0.value}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
                
            }
        }.resume()
    }
}
