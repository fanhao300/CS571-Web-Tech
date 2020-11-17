//
//  HomeScreenView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/11/20.
//

import SwiftUI

struct HomeScreenView: View {
    var favoriteStocks: [StockIntro] = []
    var portfolioStocks: [StockIntro] = []
    
    var body: some View {
        NavigationView {
            List {
                Text("November 23, 2020")
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                
                Text("PORTFOLIO")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.vertical, -2.0)
                    .listRowBackground(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                
                VStack(alignment: .leading) {
                    Text("Net Worth")
                        .font(.title2)
                    Text("20000.00")
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                }
                
                ForEach(portfolioStocks) { stock in
                    Stockcell(stock: stock)
                }
                
                
                Text("FAVORITES")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.vertical, -2.0)
                    .listRowBackground(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
                ForEach(favoriteStocks) { stock in
                    Stockcell(stock: stock)
                }
                
            }
            .environment(\.defaultMinListRowHeight, 5)
            .navigationTitle("Stocks")
        }
    }
}

struct Stockcell: View {
    var stock: StockIntro
    var body: some View {
        NavigationLink(destination: Text(stock.ticker)) {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .fontWeight(.bold)
                if stock.sharesNum != nil {
                    if (Double(stock.sharesNum!)! > 1) {
                        Text(stock.sharesNum! + " shares")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    else {
                        Text(stock.sharesNum! + " share")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                else {
                    Text(stock.company)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(stock.lastPrice)
                    .fontWeight(.bold)
                
                if (Double(stock.change)! < 0){
                    HStack {
                        Image(systemName: "arrow.down.right")
                            .foregroundColor(.red)
                            .padding(.trailing, 2.0)
                            .font(.system(size: 13.0))
                        
                        Text(stock.change)
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
                else if (Double(stock.change)! > 0){
                    HStack {
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.green)
                            .padding(.trailing, 2.0)
                            .font(.system(size: 13.0))
                        
                        Text(stock.change)
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
                else {
                    Text(stock.change)
                        .font(.subheadline)
                    
                }
            }
        }
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(favoriteStocks: favoriteStocks, portfolioStocks: portfolioStocks)
    }
}
