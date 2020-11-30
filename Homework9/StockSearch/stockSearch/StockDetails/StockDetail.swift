//
//  StockDetail.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/28/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class StockDetail: ObservableObject{
    @Published var stockInfo = StockInfo(ticker:"default", company: "defalut")
    
    @Published var about: String = ""

    @Published var priceOpen: Double = 0
    @Published var priceHigh: Double = 0
    @Published var priceLow: Double = 0
    @Published var priceMid: Double = 0
    @Published var priceBid: Double = 0
    @Published var volume: Int = 0

    @Published var marketValue: Double = 0
//    {
//        self.stockInfo.sharesNum! * self.priceCurrent
//    }
    @Published var isOwned: Bool = false
    @Published var isFavorite: Bool = false
    var isGetCompany: Bool = false
    var isGetLatestPrice: Bool = false
    var isGetHistoricalPrice: Bool = false
    var isGetNews: Bool = false
    
    var statsList: [String] {
        [
            String(format: "Current Price: %.2f", self.stockInfo.lastPrice!),
            String(format: "Open Price: %.2f", self.priceOpen),
            String(format: "High Price: %.2f", self.priceHigh),
            String(format: "Low Price: %.2f", self.priceLow),
            String(format: "Mid Price: %.2f", self.priceMid),
            String("Volume: \(self.volume.formattedWithSeparator)"),
            String(format: "Bid Price: %.2f", self.priceBid)
        ]
    }
    
    init (ticker: String){
        self.stockInfo.ticker = ticker
        //Fetch data
        //1. stocks company information
        var url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/company/\(ticker)"
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                print(json)
                self.stockInfo.company = json["name"].stringValue
                self.about = json["description"].stringValue
                self.isGetCompany.toggle()
            }
        }
        
        //2. stock lastest price information
        url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/stock/latest/\(ticker)"
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                print(json)
                self.stockInfo.change = json["change"].doubleValue
                self.stockInfo.lastPrice = json["last"].doubleValue
                self.priceOpen = json["open"].doubleValue
                self.priceHigh = json["high"].doubleValue
                self.priceLow = json["low"].doubleValue
                self.priceMid = json["mid"].doubleValue
                self.priceBid = json["bidPrice"].doubleValue
                self.volume = json["volume"].intValue
                self.isGetLatestPrice.toggle()
            }
        }
        //TODO: 3. news
        //TODO: 4. historial data
        
        //5. stock buys and favorite(by chenking userdefalut)
        let favStockStorage = HomeScreenData.getStocksInUserDefault(type: "favorite", defaultData: [])
        let sharesStorage = HomeScreenData.getStocksInUserDefault(type: "shares", defaultData: [])
        
        for stock in favStockStorage{
            if ticker == stock.ticker{
                self.isFavorite = true
                break
            }
        }
        
        for stock in sharesStorage{
            if ticker == stock.ticker{
                self.isOwned = true
                self.stockInfo.sharesNum = stock.shares
                self.marketValue = self.stockInfo.sharesNum! * self.stockInfo.lastPrice!
            }
        }
        
        
        
        
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

