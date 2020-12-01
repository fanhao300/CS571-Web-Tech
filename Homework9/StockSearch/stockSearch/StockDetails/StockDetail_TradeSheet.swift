//
//  StockDetail_TradeSheet.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI

struct StockDetail_TradeSheet: View {
    @EnvironmentObject var stockDetail: StockDetail
    @EnvironmentObject var data: HomeScreenData
    
    @State var sharesToBuy: String = ""
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                        showSheet.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
                Spacer()
            }.padding()
            
            Text("Trade \(stockDetail.stockInfo.company) shares")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack(alignment:.bottom) {
                    TextField("0", text: $sharesToBuy)
                        .font(.system(size: 64))
                        .keyboardType(.numberPad)
                    
                    if Double(sharesToBuy) ?? 0 > 1{
                        Text("Shares")
                            .font(.largeTitle)
                    }
                    else {
                        Text("Share")
                            .font(.largeTitle)
                    }
                }
                
                Text(String(format: "x $%.2f/share = $%.2f", stockDetail.stockInfo.lastPrice!, stockDetail.stockInfo.lastPrice! * (Double(sharesToBuy) ?? 0)))
            }
            
            Spacer()
            
            VStack(spacing: 15) {
                Text("$\(String(format: "%.2f", data.balance)) available to buy \(stockDetail.stockInfo.ticker)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                HStack {
                    Button("Buy", action: {
                        if let shares = Double(sharesToBuy){
                            if (shares <= 0){
                                //TODO: Can not buy less than 0 share
                            }
                            else if (shares * stockDetail.stockInfo.lastPrice! > data.balance){
                                //TODO:Not enough money to but
                            }
                            else {
                                //BUY
                                //1 update balance
                                data.balance -= shares * stockDetail.stockInfo.lastPrice!
                                //2 update stock detail
                                stockDetail.stockInfo.sharesNum += shares
                                //3 update data.portfolioStocks
                                data.portfolioStocks = data.portfolioStocks.filter{
                                    $0.ticker != stockDetail.stockInfo.ticker
                                }
                                data.portfolioStocks.append(stockDetail.stockInfo)
                                stockDetail.isOwned = true
                                //4 update data.favoriteStocks
                                for (index,stock) in data.favoriteStocks.enumerated(){
                                    if stock.ticker == stockDetail.stockInfo.ticker{
                                        data.favoriteStocks[index] = stockDetail.stockInfo
                                        break
                                    }
                                }
                                
                                //TODO: congratulation
                                showSheet.toggle()
                            }
                        }
                        else {
                            //TODO: Please enter a valid amount
                        }
                        
                    })
                        .frame(width: 160, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25)
                    
                    Button("Sell", action: {
                        if let shares = Double(sharesToBuy){
                            if (shares <= 0){
                                //TODO: Can not sell less than 0 share
                            }
                            else if (shares > stockDetail.stockInfo.sharesNum){
                                //TODO:Not enough to sell
                            }
                            else {
                                //SELL
                                //1 update balance
                                data.balance += shares * stockDetail.stockInfo.lastPrice!
                                //2 update stock detail
                                stockDetail.stockInfo.sharesNum -= shares
                                //3 update data.portfolioStocks
                                data.portfolioStocks = data.portfolioStocks.filter{
                                    $0.ticker != stockDetail.stockInfo.ticker
                                }
                                if stockDetail.stockInfo.sharesNum > 0  {
                                    data.portfolioStocks.append(stockDetail.stockInfo)
                                }
                                else {
                                    stockDetail.isOwned = false
                                }
                                //4 update data.favoriteStocks
                                for (index,stock) in data.favoriteStocks.enumerated(){
                                    if stock.ticker == stockDetail.stockInfo.ticker{
                                        data.favoriteStocks[index] = stockDetail.stockInfo
                                        break
                                    }
                                }
                                
                                
                                //TODO: congratulation
                                showSheet.toggle()
                            }
                        }
                        else {
                            //TODO: Please enter a valid amount
                        }
                        
                    })
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
