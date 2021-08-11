//
//  DataManager.swift
//  NemchenkovVG_HW2.10
//
//  Created by Владимир Немченков on 08.08.2021.
//

class DataManager {
    
    static let shared = DataManager()
    
    var currencies: [Any] = []
    
    private init() {}
}
