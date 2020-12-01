//
//  StockDetail_Portfolio.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI

struct StockDetail_Portfolio: View {
    @EnvironmentObject var stockDetail: StockDetail
    @EnvironmentObject var data: HomeScreenData
    @State var showTradeSheet: Bool = false
    @State var showCongrtulationSheet: Bool = false
    @State var sharesCount: String = ""
    @State var type: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Portfolio")
                    .font(.title)
                Spacer()
            }
            HStack {
                if stockDetail.isOwned {
                    VStack(spacing: 15) {
                        Text(String(format: "Shares Owned: %.4f", stockDetail.stockInfo.sharesNum))
                            .font(.body)
                        Text(String(format: "Market Value: $%.2f", stockDetail.marketValue))
                            .font(.body)
                    }
                } else {
                    Text("You have 0 shares of \(stockDetail.stockInfo.ticker).\nStart trading!")
                }
                Spacer()
                Button("Trade", action: {showTradeSheet.toggle()})
                    .frame(width: 150, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(25)
            }
            
            HStack {
                Text("Stats")
                    .font(.title)
                Spacer()
            }
            
            let rows: [GridItem] = Array(repeating: .init(alignment: .leading), count: 3)
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 30) {
                    ForEach(stockDetail.statsList, id: \.self) { item in
                        Text(item)
                            .font(.body)
                    }
                }
            }
            .frame(height: 100)
        }
        .sheet(isPresented: $showTradeSheet, content: {
            if showCongrtulationSheet {
                StockDetail_CongratulationSheet(
                    transactoin_type: type,
                    ticker: stockDetail.stockInfo.ticker,
                    num: $sharesCount,
                    showSheet: $showTradeSheet,
                    showCongrtulationSheet: $showCongrtulationSheet)
            }
            else {
                StockDetail_TradeSheet(
                    sharesCount: $sharesCount,
                    type: $type,
                    showSheet: $showTradeSheet,
                    showCongrtulationSheet: $showCongrtulationSheet)
            }
        })
    }
}
