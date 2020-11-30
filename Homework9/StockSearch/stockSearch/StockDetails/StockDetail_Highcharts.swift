//
//  StockDetail_Highcharts.swift
//  StockSearch
//
//  Created by Yizhan Miao on 11/29/20.
//

import SwiftUI
import UIKit // NOTE: for WKWebView

struct StockDetail_Highcharts: View {
    var body: some View {
        Text("Highcharts WKWebView")
                .padding()
                .frame(maxWidth: .infinity, minHeight:300, maxHeight: 300)
                .border(Color.blue)
                .padding()
    }
}

struct StockDetail_Highcharts_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail_Highcharts()
    }
}
