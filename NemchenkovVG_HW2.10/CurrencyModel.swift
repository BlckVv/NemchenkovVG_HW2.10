//
//  CurrencyModel.swift
//  NemchenkovVG_HW2.10
//
//  Created by Владимир Немченков on 08.08.2021.
//

struct CurrencyModel: Decodable {
    var date: String?
    var previousDate: String?
    var timestamp: String?
    var valute: [CurrencyInfo]
}

struct CurrencyInfo: Decodable {
    var charCode: String?
    var nominal: Double?
    var name: String?
    var value: Double?
    var previous: Double?
}
