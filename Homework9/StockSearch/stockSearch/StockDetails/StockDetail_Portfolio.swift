//
//  StockDetail_Portfolio.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI

struct StockDetail_Portfolio: View {
    let portfolio: StockDetail
    @State var showTradeSheet: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Portfolio")
                    .font(.title)
                
                Spacer()
            }
            
            HStack {
                
                if portfolio.isOwned {
                    VStack(spacing: 15) {
                        Text(String(format: "Shares Owned: %.4f", portfolio.stockInfo.sharesNum!))
                            .font(.body)
                        
                        Text(String(format: "Market Value: $%.2f", portfolio.marketValue))
                            .font(.body)
                    }
                } else {
                    Text("You have 0 shares of \(portfolio.stockInfo.ticker).\nStart trading!")
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
                    ForEach(portfolio.statsList, id: \.self) { item in
                        Text(item)
                            .font(.body)
                    }
                }
            }
            .frame(width: .infinity, height: 100)
        }
        .sheet(isPresented: $showTradeSheet, content: {
            StockDetail_TradeSheet(portfolio: portfolio)
        })
    }
}

//struct StockDetail_Portfolio_Previews: PreviewProvider {
//    static var previews: some View {
//        StockDetail_Portfolio(portfolio: myFooStockDetail)
//    }
//}
