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
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("About")
                    .font(.title3)
                Spacer()
            }
            
            VStack(alignment: .trailing, spacing: 8) {
                VStack {
                    Text(about)
                        .font(.footnote)
                }
                .frame(maxHeight: isCollapsed ? 50 : .none)
                
                Button(isCollapsed ? "Show more..." : "Show less") {
                    withAnimation{
                        isCollapsed.toggle()
                    }
                }
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct StockDetail_About_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_About(about: "Established in 2009, Alibaba Cloud ( alibabacloud.com ), the digital technology and intelligence backbone of Alibaba Group, is among the world's top three IaaS providers, according to Gartner. It is also the largest provider of public cloud services in China, according to IDC. Alibaba Cloud provides a comprehensive suite of cloud computing services to businesses worldwide, including merchants doing business on Alibaba Group marketplaces, start-ups, corporations and public services. Alibaba Cloud is the official Cloud Services Partner of the International Olympic Committee. SOURCE Alibaba Cloud Related Links https://www.alibabacloud.com")
    }
}
