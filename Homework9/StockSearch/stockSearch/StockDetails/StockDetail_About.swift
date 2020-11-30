//
//  StockDetail_About.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI

struct StockDetail_About: View {
    let about: String
    @State var isCollapsed: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("About")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .trailing, spacing: 8) {
                VStack {
                    Text(about)
                }
                .frame(maxHeight: isCollapsed ? 50 : .none)
                
                Button(isCollapsed ? "Show more..." : "Show less") {isCollapsed.toggle()}
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct StockDetail_About_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_About(about: myFooStockDetail.about)
    }
}
