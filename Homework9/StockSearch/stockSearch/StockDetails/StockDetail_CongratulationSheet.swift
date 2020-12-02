//
//  StockDetail_CongratulationSheet.swift
//  StockSearch
//
//  Created by Hao Fan on 12/1/20.
//

import SwiftUI

struct StockDetail_CongratulationSheet: View {
    var transactoin_type: String
    var ticker: String
    @Binding var num: String
    @Binding var showSheet: Bool
    @Binding var showCongrtulationSheet: Bool
    
    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
        VStack {
            HStack { Spacer() }
            Spacer()
            Text("Congratulations!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.bottom)
            
            if Double(num) ?? 0 > 1 {
                Text("You have sucessfully \(transactoin_type) \(num) shares of \(ticker)")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            else {
                Text("You have sucessfully \(transactoin_type) \(num) share of \(ticker)")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Button(action: {
                showSheet = false
                showCongrtulationSheet = false
                num = ""
            }, label: {
                Text("Done")
                    .font(.footnote)
                    .fontWeight(.medium)
            })
            .frame(width: 350, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.green)
            .background(Color.white)
            .cornerRadius(25)
        }
        .padding(.bottom)
        .cornerRadius(10)
    }
    }
   
}

struct StockDetail_CongratulationSheet_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_CongratulationSheet(
            transactoin_type: "bought",
            ticker: "AAPL",
            num: .constant("1.2"),
            showSheet: .constant(true),
            showCongrtulationSheet: .constant(true))
    }
}
