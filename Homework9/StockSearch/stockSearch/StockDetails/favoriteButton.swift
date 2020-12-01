//
//  favoriteButton.swift
//  StockSearch
//
//  Created by Hao Fan on 11/30/20.
//

import SwiftUI

struct favoriteButton: View {
    @Binding var isFavorite: Bool
    @Binding var showAdd: Bool
    @Binding var showDelete: Bool
    @EnvironmentObject var homeScreenData:HomeScreenData
    var stock: StockInfo
    
    var body: some View {
        if isFavorite{
            Button(action: {
                isFavorite.toggle()
                homeScreenData.favoriteStocks = homeScreenData.favoriteStocks.filter {
                    $0.ticker != stock.ticker
                }
                withAnimation{
                    self.showDelete = true
                }
            }) {
                Image(systemName: "plus.circle.fill")
            }
        }
        else {
            Button(action: {
                isFavorite.toggle()
                homeScreenData.favoriteStocks.append(stock)
                withAnimation{
                    self.showAdd = true
                }
            }) {
                Image(systemName: "plus.circle")
            }
        }
    }
}
