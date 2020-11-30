//
//  StockDetailView.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/28/20.
//

import SwiftUI

struct StockDetailView: View {
    //TODO: change to @Binding
    @StateObject var stockDetail: StockDetail
    @EnvironmentObject var data: HomeScreenData

    var body: some View {
        if stockDetail.isGetCompany && stockDetail.isGetLatestPrice{
            ScrollView {
                VStack {
                    StockDetail_Header(stockInfo: stockDetail.stockInfo)
                    
                    StockDetail_Highcharts()
                    
                    StockDetail_Portfolio(portfolio: stockDetail)
                    
                    StockDetail_About(about: stockDetail.about)
                }
                .padding()
            }
        }
        else {
            loadingView()
        }
        
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stockDetail: StockDetail(ticker: "AAPL"))
    }
}
