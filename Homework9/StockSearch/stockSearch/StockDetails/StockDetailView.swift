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
        if stockDetail.isGetCompany && stockDetail.isGetLatestPrice &&
            stockDetail.isGetNews{
            ScrollView {
                VStack {
                    StockDetail_Header(stockInfo: stockDetail.stockInfo)
                    
                    StockDetail_Highcharts()
                    
                    StockDetail_Portfolio()
                        .environmentObject(stockDetail)
                    
                    StockDetail_About(about: stockDetail.about)
                    
                    StockDetail_News(newsList: stockDetail.newsList)
                    
//                    List(stockDetail.newsList) { item in
//                        StockDetail_NewsRow(news: item)
//                    }
                    
                }
                .padding(.horizontal, 5)
            }
            .navigationBarTitle(stockDetail.stockInfo.ticker)
            .navigationBarItems(trailing: favoriteButton(isFavorite: $stockDetail.isFavorite, stock: stockDetail.stockInfo))
        }
        else {
            loadingView()
        }
        
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(stockDetail: StockDetail(ticker: "BABA"))
    }
}
