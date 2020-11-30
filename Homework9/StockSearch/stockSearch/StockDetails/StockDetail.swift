//
//  StockDetail.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/28/20.
//

import Foundation

struct StockDetail {
    let ticker: String
    let company: String
    let about: String
    
    let ownedShares: Double
    let priceCurrent: Double
    let priceOpen: Double
    let priceHigh: Double
    let priceLow: Double
    let priceMid: Double
    let priceBid: Double
    let volume: Int

    var marketValue: Double {
        self.ownedShares * self.priceCurrent
    }
    var isOwned: Bool {
        self.ownedShares > 0
    }
    
    var statsList: [String] {
        [
            String(format: "Current Price: %.2f", self.priceCurrent),
            String(format: "Open Price: %.2f", self.priceOpen),
            String(format: "High Price: %.2f", self.priceHigh),
            String(format: "Low Price: %.2f", self.priceLow),
            String(format: "Mid Price: %.2f", self.priceMid),
            String("Volume: \(self.volume.formattedWithSeparator)"),
            String(format: "Bid Price: %.2f", self.priceBid)
        ]
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

let myFooStockDetail = StockDetail(
    ticker: "AAPL", company: "Apple Inc", about: "Apple Inc. (Apple) designs, manufactures and markets mobile communication and media devices, personal computers, and portable digital music players, and a variety of related software, services, peripherals, networking solutions, and third-party digital content and applications. The Company's products and services include iPhone, iPad, Mac, iPod, Apple TV, a portfolio of consumer and professional software applications, the iOS and OS X operating systems, iCloud, and a variety of accessory, service and support offerings. The Company also delivers digital content and applications through the iTunes Store, App StoreSM, iBookstoreSM, and Mac App Store. The Company distributes its products worldwide through its retail stores, online stores, and direct sales force, as well as through third-party cellular network carriers, wholesalers, retailers, and value-added resellers. In February 2012, the Company acquired app-search engine Chomp. ",
    ownedShares: 10, priceCurrent: 204.72,
    priceOpen: 204.07, priceHigh:333.2, priceLow: 203.37, priceMid: 0.00,
    priceBid: 0.00, volume: 51195593)
