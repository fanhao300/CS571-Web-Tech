//
//  DataManage.swift
//  StockSearch
//
//  Created by Hao Fan on 11/11/20.
//

import Foundation

struct StockIntro: Identifiable{
    var id = UUID()
    var ticker: String
    var company: String
    var lastPrice: String
    var change: String
    var sharesNum: String? = nil
    
    init(ticker: String, company: String, lastPrice: Double, change: Double) {
        self.ticker = ticker
        self.company = company
        self.lastPrice = String(format: "%.2f", lastPrice)
        self.change = String(format: "%.2f", change)
    }
    
    init(ticker: String, company: String, lastPrice: Double, change: Double, sharesNum: Double) {
        self.ticker = ticker
        self.company = company
        self.lastPrice = String(format: "%.2f", lastPrice)
        self.change = String(format: "%.2f", change)
        self.sharesNum = String(format: "%.2f", sharesNum)
    }
}

var favoriteStocks = [
    StockIntro(ticker: "AMZN", company: "Amazon Inc", lastPrice: 123.45, change: -12.34),
    StockIntro(ticker: "AAPL", company: "Apple Inc", lastPrice: 345.678, change: 12.34, sharesNum: 2.3),
]

var portfolioStocks = [
    StockIntro(ticker: "AAPL", company: "Apple Inc", lastPrice: 345.678, change: -2.34, sharesNum: 2.3),
    StockIntro(ticker: "GOOG", company: "Google Inc", lastPrice: 45.678, change: 12.34, sharesNum: 0.3),
]
