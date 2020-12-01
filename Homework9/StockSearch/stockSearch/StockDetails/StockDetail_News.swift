//
//  StockDetail_News.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI
import KingfisherSwiftUI

struct StockDetail_News: View {
    let newsList: [News]
    var body: some View {
        
        VStack {
            HStack {
                Text("News")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
            
            // Headline News
            StockDetail_NewsHeadline(news: newsList[0])
            
            Divider()
            
            // News List
//            ForEach(newsList[0...newsList.count]) { item in
//                StockDetail_NewsRow(news: item)
//            }
        }
        
//        KFImage(URL(string: newsList[1].urlToImage))
//            .resizable()
//            .cornerRadius(15)
    }
}

struct StockDetail_News_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_News(newsList: myFooNewsList)
    }
}
