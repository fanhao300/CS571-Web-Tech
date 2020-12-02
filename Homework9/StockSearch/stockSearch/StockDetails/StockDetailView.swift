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
    @State var showAdd: Bool = false
    @State var showDelete: Bool = false

    var body: some View {
        if stockDetail.isGetCompany && stockDetail.isGetLatestPrice &&
            stockDetail.isGetNews{
            ScrollView {
                VStack {
                    StockDetail_Header(stockInfo: stockDetail.stockInfo)
                    
                    Highchart(ticker: stockDetail.stockInfo.ticker)
                        .frame(height: 366)
                        .padding(.all, -12.0)
                    
                    StockDetail_Portfolio()
                        .environmentObject(stockDetail)
                    
                    StockDetail_About(about: stockDetail.about)
                    
                    StockDetail_News(newsList: stockDetail.newsList)
                    
                }
                .padding([.leading, .bottom, .trailing])
            }
            .navigationBarTitle(stockDetail.stockInfo.ticker)
            .navigationBarItems(
                trailing:favoriteButton(
                    isFavorite: $stockDetail.isFavorite,
                    showAdd: $showAdd,
                    showDelete: $showDelete,
                    stock: stockDetail.stockInfo
                ))
            .toast(isShowing: $showAdd,
                   text: Text("Adding \(stockDetail.stockInfo.ticker) to Favorites"))
            .toast(isShowing: $showDelete,
                   text: Text("Removing \(stockDetail.stockInfo.ticker) from Favorites"))
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
