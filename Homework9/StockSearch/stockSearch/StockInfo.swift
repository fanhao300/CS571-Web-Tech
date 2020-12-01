//
//  DataManage.swift
//  StockSearch
//
//  Created by Hao Fan on 11/11/20.
//

import Foundation

class StockInfo: Identifiable, ObservableObject{
    var id = UUID()
    var ticker: String
    var company: String
    @Published var lastPrice: Double?
    @Published var change: Double?
    @Published var sharesNum: Double
    
    init(ticker: String, company: String, lastPrice: Double?=nil, change: Double?=nil, sharesNum: Double=0){
        self.ticker = ticker
        self.company = company
        self.lastPrice = lastPrice
        self.change = change
        self.sharesNum = sharesNum
    }
}


//For test
//var favoriteStocksInstance = [
//    StockInfo(ticker: "AMZN", company: "Amazon Inc", lastPrice: 123.45, change: -12.34"),
//    StockInfo(ticker: "AAPL", company: "Apple Inc", lastPrice: 345.678, change: "12.34", sharesNum: "2.3"),
//]
//
//var portfolioStocksInstance = [
//    StockInfo(ticker: "AAPL", company: "Apple Inc", lastPrice: "345.678", change: "-2.34", sharesNum: "2.3"),
//    StockInfo(ticker: "GOOG", company: "Google Inc", lastPrice: "45.678", change: "12.34", sharesNum: "0.3"),
//]
