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
                    .font(.title3)
                
                Spacer()
            }
            
            // Headline News
            StockDetail_NewsHeadline(news: newsList[0])
            
            Divider()
            
            // News List
            
//            List(newsList) {item in
//                StockDetail_NewsRow(news: item)
//            }
            VStack {
                ForEach(newsList) {item in
                    StockDetail_NewsRow(news: item)
                }
            }
            //.scaledToFill()
            //.frame(height: .infinity)
            
        }
        
//        KFImage(URL(string: newsList[1].urlToImage))
//            .resizable()
//            .cornerRadius(15)
    }
}

struct StockDetail_News_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            StockDetail_News(newsList: myFooNewsList)
        }
        
    }
}
