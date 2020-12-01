//
//  favoriteButton.swift
//  StockSearch
//
//  Created by Hao Fan on 11/30/20.
//

import SwiftUI

struct favoriteButton: View {
    @Binding var isFavorite: Bool
    @EnvironmentObject var homeScreenData:HomeScreenData
    var stock: StockInfo
    
    var body: some View {
        if isFavorite{
            Button(action: {
                isFavorite.toggle()
                homeScreenData.favoriteStocks = homeScreenData.favoriteStocks.filter {
                    $0.ticker != stock.ticker
                }
            }) {
                Image(systemName: "plus.circle.fill")
            }
        }
        else {
            Button(action: {
                isFavorite.toggle()
                homeScreenData.favoriteStocks.append(stock)
            }) {
                Image(systemName: "plus.circle")
            }
        }
    }
}
