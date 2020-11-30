//
//  SearchView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/29/20.
//

import SwiftUI



struct SearchView: View {
//    @Binding var text: String
    var autoComplete: [AutoCompleteData]
//    @State var autoComplete = [
//        AutoCompleteData(ticker: "AAPL", company: "AMAZON"),
//        AutoCompleteData(ticker: "AWS", company: "BBB")
//    ]
    
    var body: some View {
        ForEach (autoComplete) { stock in
            NavigationLink(destination: Text(stock.ticker)) {
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
