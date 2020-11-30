//
//  StockStorage.swift
//  StockSearch
//
//  Created by Hao Fan on 11/29/20.
//

import Foundation

struct StockStorage: Codable{
    var ticker: String
    var company: String = ""
    var shares: Double = 0
}
