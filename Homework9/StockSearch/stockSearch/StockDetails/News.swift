//
//  News.swift
//  StockSearch
//
//  Created by Hao Fan on 11/30/20.
//

import Foundation

struct News: Identifiable {
    let urlToImage: String
    let source: String
    let title: String
    let url: String
    let publishedAt: String
    var id: String {url}
}


let myFooNewsList: [News] = [
    News(
        urlToImage: "https://i.insider.com/5f9c2b106f5b3100117246dc?width=1200&format=jpeg",
        source: "Business Insider",
        title: "Apple's Q4 earnings report was missing the most important number Wall Street was waiting for (AAPL)",
        url: "https://www.businessinsider.com/apple-iphone-12-sales-mystery-after-q4-earnings-report-2020-10",
        publishedAt: "2020-10-30T16:46:32Z"),
    News(urlToImage: "https://9to5mac.com/wp-content/uploads/sites/6/2020/11/tech-stocks-up.jpg?quality=82&strip=all",
         source: "9to5Mac",
         title: "AAPL and other tech stocks up in possible response to election uncertainty",
         url: "https://9to5mac.com/2020/11/04/aapl-and-other-tech-stocks-up-in-possible-response-to-election-uncertainty/",
         publishedAt: "2020-11-04T14:01:01Z")
]
