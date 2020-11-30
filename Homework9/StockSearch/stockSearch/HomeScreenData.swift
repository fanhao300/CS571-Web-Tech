//
//  HomeScreenData.swift
//  StockSearch
//
//  Created by Hao Fan on 11/29/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeScreenData: ObservableObject{
    static let defaultFavStocks = [
        StockStorage(ticker: "AAPL", company: "Apple Inc."),
        StockStorage(ticker: "AMZN", company: "Amazon Inc.")
    ]
    static let defaultPortStocks = [
        StockStorage(ticker: "AAPL", company: "Apple Inc."),
        StockStorage(ticker: "GOOG", company: "Google Inc.")
    ]
    static let defaultBoughtStocks = [
        StockStorage(ticker:"AAPL", shares: 1.2),
        StockStorage(ticker:"GOOG", shares: 0.3)
    ]
    
    
    @Published var favoriteStocks = [StockInfo]() {
        didSet{
            persistStocks("favorite", self.favoriteStocks)
        }
    }
    @Published var portfolioStocks = [StockInfo]() {
        didSet{
            persistStocks("portfolio", self.portfolioStocks)
        }
    }
    @Published var netWorth:String = loadNetWorth(){
        didSet{
            persistNetWorth()
        }
    }
    @Published var date:String
    
    var isFinish: Bool = false
    
    
    static private func updateDate() -> String{
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none

        let datetime = formatter.string(from: now)
        return datetime
    }
    
    private func persistStocks(_ type: String, _ data: [StockInfo]){
        var storage = [StockStorage]()
        for stock in data{
            let storageCell = StockStorage(ticker: stock.ticker, company: stock.company)
            storage.append(storageCell)
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(storage) {
            UserDefaults.standard.set(encoded, forKey: type)
        }
    }
    
    static private func loadNetWorth() -> String{
        let netWorth = UserDefaults.standard.string(forKey:"netWorth")
        if let netWorth = netWorth{
            return netWorth
        }
        return "20000.00"
    }
    
    private func persistNetWorth(){
        UserDefaults.standard.set(netWorth, forKey: "netWorth")
    }
    
    
    
    private func getStocksInUserDefault(type: String, defaultData:[StockStorage]) -> [StockStorage]{
        let savedStocks = UserDefaults.standard.object(forKey: type)
        var ret: [StockStorage] = defaultData
        print(type)
        print(ret)
//        print(savedStocks)
        if let savedStocks = savedStocks as? Data{
            let decoder = JSONDecoder()
            ret = (try? decoder.decode([StockStorage].self, from: savedStocks)) ?? defaultData
        }
        print(ret)
        return ret
    }
    
    private func getStockInfo(json: JSON, stockStorage: [StockStorage], shares: [StockStorage]) -> [StockInfo]{
        var ret = [StockInfo]()
        for stock in stockStorage{
            for (_,jsStock):(String, JSON) in json {
                let ticker = jsStock["ticker"].stringValue
                if ticker == stock.ticker{
                    let lastPrice = String(format: "%.2f", jsStock["last"].doubleValue)
                    let change = String(format: "%.2f", jsStock["change"].doubleValue)
                    let stockInfo = StockInfo(ticker: ticker, company: stock.company, lastPrice: lastPrice, change: change)
                    ret.append(stockInfo)
                    break
                }
            }
        }
        
        for (index,stock) in ret.enumerated(){
            for stockStorage in shares{
                if stock.ticker == stockStorage.ticker{
                    let shares = stockStorage.shares
                    ret[index].sharesNum = String(format: "%.2f", shares)
                }
            }
        }
        return ret
    }
    
    
    init(){
        //If want to reset userDefalut, uncomment these lines
        
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
        self.date = HomeScreenData.updateDate()
        
        //Get stocks from userDefault
        let favStockStorage = getStocksInUserDefault(type: "favorite", defaultData: HomeScreenData.defaultFavStocks)
        let portStocksStorage = getStocksInUserDefault(type: "portfolio", defaultData: HomeScreenData.defaultPortStocks)
        let sharesStorage = getStocksInUserDefault(type: "shares", defaultData: HomeScreenData.defaultBoughtStocks)
        
        //get all tickers from userDefault
        var tickers = ""
        for stock in favStockStorage{
            tickers += stock.ticker + ","
        }
        for stock in portStocksStorage{
            tickers += stock.ticker + ","
        }
        print(tickers)
        print(self.date)
        
        //Fetch data
        let url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/stocks/latest/" + tickers
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                print(json)
                self.favoriteStocks = self.getStockInfo(json: json, stockStorage: favStockStorage, shares: sharesStorage)
                self.portfolioStocks = self.getStockInfo(json: json, stockStorage: portStocksStorage, shares: sharesStorage)
                self.isFinish.toggle()
                print(self.favoriteStocks)
            }
        }
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
