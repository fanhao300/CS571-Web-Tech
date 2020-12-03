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
    
    @State var isShowInvalid: Bool = false
    @State var isShowBuyLessThanZero: Bool = false
    @State var isShowSellLessThanZero: Bool = false
    @State var isShowNotEnoughMoney: Bool = false
    @State var isShowNotEnoughShares: Bool = false
    
    @Binding var sharesCount: String
    @Binding var type: String
    @Binding var showSheet: Bool
    @Binding var showCongrtulationSheet: Bool
    
    func buyAction(){
        if let shares = Double(sharesCount){
            if (shares <= 0){
                //Cannot buy less than 0 share
                withAnimation {
                    self.isShowBuyLessThanZero = true
                }
            }
            else if (shares * stockDetail.stockInfo.lastPrice! > data.balance){
                //Not enough money to buy
                withAnimation {
                    self.isShowNotEnoughMoney = true
                }
            }
            else {
                //BUY
                //1 update balance
                data.balance -= shares * stockDetail.stockInfo.lastPrice!
                //2 update stock detail
                stockDetail.stockInfo.sharesNum += shares
                stockDetail.marketValue = stockDetail.stockInfo.sharesNum * stockDetail.stockInfo.lastPrice!
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
                
                //Congratulation
                type = "bought"
                withAnimation {
                    showCongrtulationSheet.toggle()
                }
            }
        }
        else {
            //Please enter a valid amount
            withAnimation {
                self.isShowInvalid = true
            }
        }
    }
    
    func sellAction(){
        if let shares = Double(sharesCount){
            if (shares <= 0){
                //TODO: Can not sell less than 0 share
                withAnimation {
                    self.isShowSellLessThanZero = true
                }
            }
            else if (shares > stockDetail.stockInfo.sharesNum){
                //TODO:Not enough to sell
                withAnimation {
                    self.isShowNotEnoughShares = true
                }
            }
            else {
                //SELL
                //1 update balance
                data.balance += shares * stockDetail.stockInfo.lastPrice!
                //2 update stock detail
                stockDetail.stockInfo.sharesNum -= shares
                stockDetail.marketValue = stockDetail.stockInfo.sharesNum * stockDetail.stockInfo.lastPrice!
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
                
                //Congratulation
                type = "sold"
                withAnimation {
                    showCongrtulationSheet.toggle()
                }
            }
        }
        else {
            //Please enter a valid amount
            withAnimation {
                self.isShowInvalid = true
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showSheet.toggle()
                    sharesCount = ""
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
                Spacer()
            }
            .padding(.vertical)
            
            Text("Trade \(stockDetail.stockInfo.company) shares")
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack(alignment:.bottom) {
                    TextField("0", text: $sharesCount)
                        .font(.system(size: 64))
                        .keyboardType(.decimalPad)
                    
                    if Double(sharesCount) ?? 0 > 1{
                        Text("Shares")
                            .font(.largeTitle)
                    }
                    else {
                        Text("Share")
                            .font(.largeTitle)
                    }
                }
                
                Text(String(format: "x $%.2f/share = $%.2f", stockDetail.stockInfo.lastPrice!, stockDetail.stockInfo.lastPrice! * (Double(sharesCount) ?? 0)))
            }
            
            Spacer()
            
            VStack(spacing: 15) {
                Text("$\(String(format: "%.2f", data.balance)) available to buy \(stockDetail.stockInfo.ticker)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                HStack {
                    Button(action: {
                        buyAction()
                    }, label:{
                        Text("Buy")
                            .font(.footnote)
                            .fontWeight(.medium)
                    })
                    .frame(width: 160, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(25)
                    
                    Button(action: {
                            sellAction()
                        }, label:{
                            Text("Sell")
                                .font(.footnote)
                                .fontWeight(.medium)
                    })
                    .frame(width: 160, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(25)
                }
                .padding(.bottom)
                
            }
        }
        .cornerRadius(15)
        .toast(isShowing: $isShowInvalid, text: Text("Please enter a valid amount"))
        .toast(isShowing: $isShowBuyLessThanZero, text: Text("Cannot buy less than 0 share"))
        .toast(isShowing: $isShowSellLessThanZero, text: Text("Cannot sell less than 0 share"))
        .toast(isShowing: $isShowNotEnoughMoney, text: Text("Not enough money to buy"))
        .toast(isShowing: $isShowNotEnoughShares, text: Text("Not enough shares to sell"))
        .padding([.leading, .bottom, .trailing])
    }
}
