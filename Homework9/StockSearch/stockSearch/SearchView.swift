//
//  SearchView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/29/20.
//

import SwiftUI



struct SearchView: View {
    var autoComplete: [AutoCompleteData]

    
    var body: some View {
        ForEach (autoComplete) { stock in
            NavigationLink(destination: StockDetailView(stockDetail: StockDetail(ticker: stock.ticker))) {
                VStack(alignment: .leading) {
                    Text(stock.ticker)
                        .fontWeight(.bold)
                    Text(stock.company)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
}
