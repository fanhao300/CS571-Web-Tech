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

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Portfolio")
                    .font(.title3)
                Spacer()
            }
            HStack {
                if stockDetail.isOwned {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(String(format: "Shares Owned: %.4f", stockDetail.stockInfo.sharesNum))
                            .font(.caption)
                        Text(String(format: "Market Value: $%.2f", stockDetail.marketValue))
                            .font(.caption)
                    }
                } else {
                    Text("You have 0 shares of \(stockDetail.stockInfo.ticker).\nStart trading!")
                        .font(.caption)
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
                LazyHGrid(rows: rows, spacing: 15) {
                    ForEach(stockDetail.statsList, id: \.self) { item in
                        Text(item)
                            .font(.footnote)
                    }
                }
            }
            .frame(height: 100)
        }
        .sheet(isPresented: $showTradeSheet, content: {
            StockDetail_TradeSheet(showSheet: $showTradeSheet)
        })
    }
}

//struct StockDetail_Portfolio_Previews: PreviewProvider {
//    static var previews: some View {
//        var stockDetail = StockDetail(ticker: "AAPL")
//        StockDetail_Portfolio(stockDetail: .constant(stockDetail))
//    }
//}
