//
//  DataManage.swift
//  StockSearch
//
//  Created by Hao Fan on 11/11/20.
//

import Foundation

struct StockInfo: Identifiable{
    var id = UUID()
    var ticker: String
    var company: String
    var lastPrice: String? = nil
    var change: String? = nil
    var sharesNum: String? = nil
}


//For test
var favoriteStocksInstance = [
    StockInfo(ticker: "AMZN", company: "Amazon Inc", lastPrice: "123.45", change: "-12.34"),
    StockInfo(ticker: "AAPL", company: "Apple Inc", lastPrice: "345.678", change: "12.34", sharesNum: "2.3"),
]

var portfolioStocksInstance = [
    StockInfo(ticker: "AAPL", company: "Apple Inc", lastPrice: "345.678", change: "-2.34", sharesNum: "2.3"),
    StockInfo(ticker: "GOOG", company: "Google Inc", lastPrice: "45.678", change: "12.34", sharesNum: "0.3"),
]
