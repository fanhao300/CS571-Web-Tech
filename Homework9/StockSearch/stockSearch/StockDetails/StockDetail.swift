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
    @Published var isOwned: Bool = false
    @Published var isFavorite: Bool = false
    @Published var newsList = [News]()
    var isGetCompany: Bool = false
    var isGetLatestPrice: Bool = false
    var isGetNews: Bool = false
    
    var statsList: [String]{
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
    
    func getStockPrice(_ ticker: String, _ sharesStorage: [StockStorage]) {
        let url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/stock/latest/\(ticker)"
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                self.stockInfo.change = json["change"].doubleValue
                self.stockInfo.lastPrice = json["last"].doubleValue
                self.priceOpen = json["open"].doubleValue
                self.priceHigh = json["high"].doubleValue
                self.priceLow = json["low"].doubleValue
                self.priceMid = json["mid"].doubleValue
                self.priceBid = json["bidPrice"].doubleValue
                self.volume = json["volume"].intValue
                
                //update self.marketValue since it need self.stockInfo.lastPrice!
                for stock in sharesStorage{
                    if ticker == stock.ticker{
                        self.isOwned = true
                        self.stockInfo.sharesNum = stock.shares
                        self.marketValue = self.stockInfo.sharesNum * self.stockInfo.lastPrice!
                    }
                }
                if !self.isGetLatestPrice{
                    self.isGetLatestPrice.toggle()
                }
                
                print(Date())
                print(ticker, self.stockInfo.lastPrice!)
            }
        }
    }
    
    init (ticker: String){
        self.stockInfo.ticker = ticker
        
        //1. stock shares and favorite(by chenking userdefalut)
        //stock shares update in the third step.
        let favStockStorage = HomeScreenData.getStocksInUserDefault(type: "favorite", defaultData: [])
        let sharesStorage = HomeScreenData.getStocksInUserDefault(type: "shares", defaultData: [])
        
        for stock in favStockStorage{
            if ticker == stock.ticker{
                self.isFavorite = true
                break
            }
        }
        
        //Fetch data
        //2. stocks company information
        var url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/company/\(ticker)"
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                self.stockInfo.company = json["name"].stringValue
                self.about = json["description"].stringValue
                self.isGetCompany.toggle()
            }
        }
        
        //3. stock lastest price information
        getStockPrice(ticker, sharesStorage)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { timer in
            self.getStockPrices(ticker, sharesStorage)
        }
        
        //4. news
        url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/news/\(ticker)"
        AF.request(url).validate().responseJSON{ (response) in
            if let data = response.data {
                let json = JSON(data)
                var cnt = 0
                for (_,jsStock):(String, JSON) in json{
                    let news = News(urlToImage: jsStock["urlToImage"].stringValue,
                                    source: jsStock["source"].stringValue,
                                    title: jsStock["title"].stringValue,
                                    url: jsStock["url"].stringValue,
                                    publishedAt: jsStock["publishedAt"].stringValue)
                    self.newsList.append(news)
                    cnt += 1
                    if (cnt > 10) {
                        break
                    }
                }
                self.isGetNews.toggle()
            }
        }
    }
    
    func getStockPrices(_ ticker: String, _ sharesStorage: [StockStorage]) {
        if self.isGetLatestPrice{
            print(Date())
            print(ticker, self.stockInfo.lastPrice!)
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

