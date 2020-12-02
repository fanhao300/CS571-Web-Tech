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
    var elapsedTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let articleDate = formatter.date(from: self.publishedAt) else {
//            return self.publishedAt
            return "3 days ago"
        }
        
        let currentDate = Date()
        let elapsedTimeInterval: TimeInterval = articleDate.distance(to: currentDate)
        
        var elapsedTimeString: String

        switch elapsedTimeInterval {
        case let t where t < 60*60: // less than 60 min
            let stringT = String(format: "%.0f", t / 60)
            if stringT == "1"{
                elapsedTimeString = "1 minute ago"
            }
            else {
                elapsedTimeString = "\(stringT) minutes ago"
            }

        case let t where t < 24*60*60: // less than 24 hours
            let stringT = String(format: "%.0f", t / 3600)
            if stringT == "1"{
                elapsedTimeString = "1 hour ago"
            }
            else {
                elapsedTimeString = "\(stringT) hours ago"
            }
        default:
            let stringT = String(format: "%.0f", elapsedTimeInterval / 3600 / 24)
            if stringT == "1"{
                elapsedTimeString = "1 day ago"
            }
            else {
                elapsedTimeString = "\(stringT) days ago"
            }
        }
        
        return elapsedTimeString
    }
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
         publishedAt: "2020-11-04T14:01:01Z"),
    
    News(urlToImage: "https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/kxuwkqycl44kvhtcfqt3.jpg",
         source: "Gizmodo.com",
         title: "Apple's Still",
         url: "https://gizmodo.com/apples-still-getting-punished-on-wall-street-for-not-se-1845554650",
         publishedAt: "2020-11-02T21:22:00Z"),
    
    News(urlToImage: "https://static.cnbetacdn.com/thumb/article/2020/1112/5c60d787564ceb9.jpg",
         source: "Cnbeta.com",
         title: "[图]金融分析师是如何看待苹果自研芯片M1的[图]金融分析师是如何看待苹果自研芯片M1的[图]金融分析师是如何看待苹果自研芯片M1的[图]金融分析师是如何看待苹果自研芯片M1的[图]金融分析师是如何看待苹果自研芯片M1的[图]金融分析师是如何看待苹果自研芯片M1的[图]金融分析师是如何看待苹果自研芯片M1的",
         url: "https://www.cnbeta.com/articles/tech/1052343.htm",
         publishedAt: "2020-11-12T01:40:15Z")
]
