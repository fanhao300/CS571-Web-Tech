//
//  StockDetail_NewsHeadline.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/30/20.
//

import SwiftUI
import KingfisherSwiftUI

struct StockDetail_NewsHeadline: View {
    @Environment(\.openURL) var openURL
    
    let news: News
    var body: some View {
        Link(destination: URL(string: news.url)!){
            VStack(alignment: .center, spacing: 10) {
                KFImage(URL(string: news.urlToImage))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 200, alignment: .center)
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
                    Text(news.title)
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .frame(minHeight: 100)
                .padding([.leading, .bottom, .trailing], 5.0)
                
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

struct StockDetail_NewsHeadline_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_NewsHeadline(news: myFooNewsList[0])
    }
}
