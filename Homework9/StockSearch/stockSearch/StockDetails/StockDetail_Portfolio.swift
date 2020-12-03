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
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Portfolio")
                    .font(.title3)
                Spacer()
            }
            HStack {
                if stockDetail.isOwned {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(String(format: "Shares Owned: %.4f", stockDetail.stockInfo.sharesNum))
                            .font(.caption)
                        Text(String(format: "Market Value: $%.2f", stockDetail.marketValue))
                            .font(.caption)
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("You have 0 shares of \(stockDetail.stockInfo.ticker).")
                            .font(.caption)
                        Text("Start trading")
                            .font(.caption)
                    }
                }
                Spacer()
                Button("Trade", action: {showTradeSheet.toggle()})
                    .font(.callout)
                    .frame(width: 150, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(25)
            }
            
            HStack {
                Text("Stats")
                    .font(.title3)
                Spacer()
            }
            
            let rows: [GridItem] = Array(repeating: .init(alignment: .leading), count: 3)
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 12) {
                    ForEach(stockDetail.statsList, id: \.self) { item in
                        Text(item)
                            .font(.footnote)
                    }
                }
            }
            .frame(height: 80)
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
