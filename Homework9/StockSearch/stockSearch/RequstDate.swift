//
//  RequstDate.swift
//  StockSearch
//
//  Created by Hao Fan on 11/17/20.
//

import Foundation

func getStocksInfo(stocks:[StockInfo]) -> Void {
    //get all tickers
    var tickers: String = ""
    for stock in stocks{
        tickers += stock.ticker + ","
    }
    // get URL
    let url = URL(string: "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/stocks/latest/" + tickers)
    guard let requestUrl = url else { fatalError() }

    // Create URL Request
    var request = URLRequest(url: requestUrl)

    // Specify HTTP Method to use
    request.httpMethod = "GET"

    // Send HTTP Request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check if Error took place
        if let error = error {
            print("Error took place \(error)")
            return
        }
        
        // Read HTTP Response Status code
        if let response = response as? HTTPURLResponse {
            print("Response HTTP Status code: \(response.statusCode)")
        }
        
        // Convert HTTP Response Data to a simple String
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            print("Response data string:\n \(dataString)")
        }
        
    }
    task.resume()
}
