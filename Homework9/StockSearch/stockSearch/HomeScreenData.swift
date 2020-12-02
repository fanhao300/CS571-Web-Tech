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
    @Published var balance: Double = 0{
        didSet{
            persistBalance()
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
        
        //update shares userdefault
        if (type == "portfolio"){
            var storage = [StockStorage]()
            for stock in data{
                let storageCell = StockStorage(ticker: stock.ticker, shares: stock.sharesNum)
                storage.append(storageCell)
            }
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(storage) {
                UserDefaults.standard.set(encoded, forKey: "shares")
            }
        }
    }
    
    static private func loadBalance() -> Double{
        let balance = UserDefaults.standard.double(forKey:"balance")
        return balance
    }
    
    private func persistBalance(){
        UserDefaults.standard.set(balance, forKey: "balance")
    }
    
    
    static public func getStocksInUserDefault(type: String, defaultData:[StockStorage]) -> [StockStorage]{
        let savedStocks = UserDefaults.standard.object(forKey: type)
        var ret: [StockStorage] = defaultData
        if let savedStocks = savedStocks as? Data{
            let decoder = JSONDecoder()
            ret = (try? decoder.decode([StockStorage].self, from: savedStocks)) ?? defaultData
        }
        return ret
    }
    
    private func getStockInfo(json: JSON, stockStorage: [StockStorage], shares: [StockStorage]) -> [StockInfo]{
        var ret = [StockInfo]()
        for stock in stockStorage{
            for (_,jsStock):(String, JSON) in json {
                let ticker = jsStock["ticker"].stringValue
                if ticker == stock.ticker{
                    let lastPrice = jsStock["last"].doubleValue
                    let change = jsStock["change"].doubleValue
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
                    ret[index].sharesNum = shares
                }
            }
        }
        return ret
    }
    
    var netWorth: Double{
        var ret: Double = 0
        for stock in self.portfolioStocks{
            ret += stock.lastPrice! * stock.sharesNum
        }
        ret += self.balance
        return ret
    }
   
    
    init(){
        //If want to reset userDefalut, uncomment these lines
        //If want to reset userDefalut, uncomment these lines
//        if let appDomain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: appDomain)
//        }
//        UserDefaults.standard.set(200000, forKey: "balance")
        //If want to reset userDefalut, uncomment these lines
        //If want to reset userDefalut, uncomment these lines
        
        self.date = HomeScreenData.updateDate()
        self.balance = HomeScreenData.loadBalance()
        
        //Get stocks from userDefault
        let favStockStorage = HomeScreenData.getStocksInUserDefault(type: "favorite", defaultData: [])
        let portStocksStorage = HomeScreenData.getStocksInUserDefault(type: "portfolio", defaultData: [])
        let sharesStorage = HomeScreenData.getStocksInUserDefault(type: "shares", defaultData: [])
        
        //get all tickers from userDefault
        var tickers = ""
        for stock in favStockStorage{
            tickers += stock.ticker + ","
        }
        for stock in portStocksStorage{
            tickers += stock.ticker + ","
        }
        
        //Fetch data
        let url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/stocks/latest/" + tickers
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                self.favoriteStocks = self.getStockInfo(json: json, stockStorage: favStockStorage, shares: sharesStorage)
                self.portfolioStocks = self.getStockInfo(json: json, stockStorage: portStocksStorage, shares: sharesStorage)
                self.isFinish.toggle()
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
