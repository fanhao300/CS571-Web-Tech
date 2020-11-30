//
//  StockDetailView.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/28/20.
//

import SwiftUI

struct StockDetailView: View {
    //TODO: change to @Binding
    let stockInfo: StockInfo
    let portfolio: StockDetail

    var body: some View {
        ScrollView {
            VStack {
                StockDetail_Header(stockInfo: stockInfo)
                
                StockDetail_Highcharts()
                
                StockDetail_Portfolio(portfolio: portfolio)
                
                StockDetail_About(about: portfolio.about)
            }
            .padding()
        }
        
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stockInfo: StockInfo(ticker: "AAPL", company: "Apple Inc", lastPrice: "345.678", change: "2.34", sharesNum: "2.3"), portfolio: myFooStockDetail)
    }
}
