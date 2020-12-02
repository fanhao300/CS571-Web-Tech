//
//  StockDetail_NewsHeadline.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/30/20.
//

import SwiftUI
import KingfisherSwiftUI

struct StockDetail_NewsHeadline: View {
    let news: News
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            KFImage(URL(string: news.urlToImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 375, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(15)
                    
            VStack(alignment: .leading, spacing: 3) {
                HStack (spacing: 10) {
                    Text(news.source)
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Text(news.elapsedTime)
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                
                Text(news.title)
                    .font(.headline)
                    .padding(.horizontal, 10)
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
            }
        }
        .background(Color.white)
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .contextMenu(ContextMenu(menuItems: {
            Button(action: {}, label: {
                Text("Open in Safari")
                Spacer()
                Image(systemName: "safari")
            })
            
            Button(action: {}, label: {
                Text("Share on Twitter")
                Spacer()
                Image(systemName: "square.and.arrow.up")
            })
        }))
    }
}

struct StockDetail_NewsHeadline_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_NewsHeadline(news: myFooNewsList[0])
    }
}
