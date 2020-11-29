//
//  DataManage.swift
//  StockSearch
//
//  Created by Hao Fan on 11/11/20.
//

import Foundation

class HomeScreenData: ObservableObject{
    @Published var favoriteStocks:[StockInfo] = favoriteStocksInstance
    @Published var portfolioStocks:[StockInfo] = portfolioStocksInstance
    @Published var netWorth:String = "10000.00"
    @Published var date:String = updateDate()
    
    
    static func updateDate() -> String{
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none

        let datetime = formatter.string(from: now)
        return datetime
    }
    
    
    func movePortfolioStock(from source: IndexSet, to destination: Int) {
        self.portfolioStocks.move(fromOffsets: source, toOffset: destination)
    }
    func deleteFavoriteStock(at offsets: IndexSet) {
        self.favoriteStocks.remove(atOffsets: offsets)
    }
    func moveFavoriteStock(from source: IndexSet, to destination: Int) {
        self.favoriteStocks.move(fromOffsets: source, toOffset: destination)
    }
    
}


struct StockInfo: Identifiable{
    var id = UUID()
    var ticker: String
    var company: String
    var lastPrice: String? = nil
    var change: String? = nil
    var sharesNum: String? = nil
}

struct StockDetail {
    
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
