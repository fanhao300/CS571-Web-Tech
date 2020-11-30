//
//  StockDetail_Header.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/28/20.
//

import SwiftUI

struct StockDetail_Header: View {
    let stockInfo: StockInfo

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stockInfo.ticker)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(stockInfo.company)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Text("$\(stockInfo.lastPrice!)") //TODO: handel nil condition
                        .font(.title)
                    
                    renderPriceChanged(stockInfo.change!)
                        .font(.title3)
//                    switch Double(stockInfo.change!) {
//                    case let change where change < 0:
//                        changeColor = Color.red
//                    }
                    
                    
                }
                
            }
            
            Spacer()
        }
//        .padding() // XXX: do we need it?
    }
    
    func renderPriceChanged(_ priceChange: String) -> some View {
        let priceChangeNumber = Double(priceChange)!
        var textColor: Color
        
        switch priceChangeNumber {
        case let val where val < 0:
            textColor = Color.red
            
        case let val where val > 0:
            textColor = Color.green
            
        default:
            textColor = Color.gray
        }
        
        return Text("($\(String(format: "%.2f", priceChangeNumber)))").foregroundColor(textColor)
    }
}

struct StockDetail_Header_Previews: PreviewProvider {
    static var previews: some View {
        let test = StockInfo(ticker: "AAPL", company: "Apple Inc", lastPrice: "345.678", change: "-2.33", sharesNum: "2.3")
        StockDetail_Header(stockInfo: test)
    }
}
