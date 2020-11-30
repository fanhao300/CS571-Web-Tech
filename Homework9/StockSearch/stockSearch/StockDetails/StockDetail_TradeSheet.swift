//
//  StockDetail_TradeSheet.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI

struct StockDetail_TradeSheet: View {
//    @Binding var showSheet: Bool
    let portfolio: StockDetail
    @State var sharesToBuy: String = "0"
    
    var body: some View {
        VStack {
            HStack {
                
                Button(action: {
//                        showSheet.toggle()
                    
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
                Spacer()
            }.padding()
            
            Text("Trade \(portfolio.company) shares")
                .font(.caption)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack(alignment:.bottom) {
                    TextField("0", text: $sharesToBuy)
                        .font(.system(size: 64))
                        .keyboardType(.numberPad)
                    
                    Text("Shares")
                        .font(.largeTitle)
                }
                
                Text(String(format: "x $%.2f/share = $%.2f", portfolio.priceCurrent, portfolio.priceCurrent * Double(sharesToBuy)!))
            }
            
            Spacer()
            
            VStack(spacing: 15) {
                Text("$12345.67 available to buy \(portfolio.ticker)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                HStack {
                    Button("Buy", action: {})
                        .frame(width: 160, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25)
                    
                    Button("Sell", action: {})
                        .frame(width: 160, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25)
                }
                
            }
        }
        .cornerRadius(15)
        
    }
}

struct StockDetail_TradeSheet_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_TradeSheet(portfolio: myFooStockDetail)
    }
}
