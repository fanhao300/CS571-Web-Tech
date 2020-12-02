//
//  StockDetail_NewsRow.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/30/20.
//

import SwiftUI
import KingfisherSwiftUI

struct StockDetail_NewsRow: View {
    @Environment(\.openURL) var openURL
    
    let news: News
    var body: some View {
        Link(destination: URL(string: news.url)!){
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(news.source)
                        Text(news.elapsedTime)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                    
                    Text(news.title)
                        .font(.headline)
                        .frame(height: 70, alignment: .topLeading)
                        .padding(.bottom, 5)
                        .foregroundColor(.black)
                }
                .padding(.leading, 5)
                
                Spacer()
                
                KFImage(URL(string: news.urlToImage))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
                    .cornerRadius(15)
                
            }
            .background(Color.white)
            .contentShape(RoundedRectangle(cornerRadius: 15))
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    openURL(URL(string: news.url)!)
                }, label: {
                    Text("Open in Safari")
                    Spacer()
                    Image(systemName: "safari")
                })
                
                Button(action: {
                    openURL(URL(string: getTwitterURL(news.url))!)
                    
                }, label: {
                    Text("Share on Twitter")
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                })
            }))
        }
        .animation(/*@START_MENU_TOKEN@*/.linear/*@END_MENU_TOKEN@*/)
    }
    
    func getTwitterURL(_ newsURL: String) -> String{
        let encodedNewsURL = newsURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let text = "Check out this link:"
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let ret:String = "https://twitter.com/intent/tweet?text=\(encodedText)&url=\(encodedNewsURL)&hashtags=CSCI571StockApp"
        return ret
    }
}

struct StockDetail_NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_NewsRow(news: myFooNewsList[2])
    }
}
