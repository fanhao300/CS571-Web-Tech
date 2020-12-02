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
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(news.source)
                    
                    Text(news.elapsedTime)
                }
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 5)
                
                Text(news.title)
                    .font(.headline)
                    .frame(height: 70)
                    .padding(.bottom, 5)
            }
            .padding(.leading, 5)
            
            Spacer()
            
            KFImage(URL(string: news.urlToImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 95, height: 95, alignment: .center)
                .clipped()
                .cornerRadius(15)
            
        }
        .background(Color.white)
        .contentShape(RoundedRectangle(cornerRadius: 15))
//        .cornerRadius(15)
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
