//
//  StockDetail_NewsRow.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/30/20.
//

import SwiftUI
import KingfisherSwiftUI

struct StockDetail_NewsRow: View {
    let news: News
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(news.source)
                    
                    Text("XXX time age")
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                Text(news.title)
                    .font(.headline)
                    .frame(height: 70)
            }
            
            Spacer()
            
            KFImage(URL(string: news.urlToImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .clipped()
                .cornerRadius(15)
            
        }
        .background(Color.white)
        .cornerRadius(15)
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

struct StockDetail_NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_NewsRow(news: myFooNewsList[1])
    }
}
