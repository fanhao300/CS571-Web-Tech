//
//  HomeScreenView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/11/20.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct HomeScreenView: View {
    @EnvironmentObject var data: HomeScreenData;
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State var autoComplete = [AutoCompleteData]()
    
    @State var timestampRecord: Double = 0

    var body: some View {
        if data.isFinish {
            NavigationView {
                List {
                    if searchBar.text.isEmpty {
                        Text(data.date)
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)

                        Section(header: Text("PORTFOLIO")){
                            VStack(alignment: .leading) {
                                Text("Net Worth")
                                    .font(.title2)
                                Text(String(format: "%.2f", data.netWorth))
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                                    .fontWeight(.bold)
                            }
                            ForEach(data.portfolioStocks) { stock in
                                Stockcell(stock: stock)
                            }
                            .onMove(perform: data.movePortfolioStock)
                        }
                        
                        Section(header: Text("FAVORITES")){
                            ForEach(data.favoriteStocks) { stock in
                                Stockcell(stock: stock)
                            }
                            .onDelete(perform: data.deleteFavoriteStock)
                            .onMove(perform: data.moveFavoriteStock)
                            
                        }
                        HStack {
                            Spacer()
                            Link("Powered by Tiingo",
                                destination: URL(string: "https://www.tiingo.com")!)
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                    }
                    else {
                        if searchBar.text.count >= 3{
                            SearchView(autoComplete: autoComplete)
                        }
                    }
                }
                .navigationTitle("Stocks")
                .add(self.searchBar)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        EditButton()
                    }
                }
                .onChange(of: searchBar.text, perform: { value in
                    self.timestampRecord = Date().timeIntervalSince1970
                    if searchBar.text.count >= 3{
                        let debouncer = Debouncer(delay: 0.5)
                        debouncer.run(action: {
                            loadData(value: value)
                        })
                    }
                    else {
                        self.autoComplete = []
                    }
                })
            }
        }
        else {
            loadingView()
        }
    }
    
    
    func loadData(value: String) {
        let timestampNow = Date().timeIntervalSince1970
        if timestampNow - timestampRecord > 0.5 && timestampNow - timestampRecord < 0.6{
            let url = "http://ttxhzz.us-east-1.elasticbeanstalk.com/api/autocomplete/" + value
            AF.request(url).validate().responseJSON{ (response) in
                if let data = response.data {
                    let json = JSON(data)
                    var stocksArray: [AutoCompleteData] = []
                    for (_,jsStock):(String, JSON) in json{
                        let stock = AutoCompleteData(ticker: jsStock["ticker"].stringValue, company: jsStock["name"].stringValue)
                        stocksArray.append(stock)
                    }
                    self.autoComplete = stocksArray
                }
            }
        }
    }
}

struct Stockcell: View {
    @StateObject var stock: StockInfo
    
    var body: some View {
        NavigationLink(
            destination: StockDetailView(stockDetail: StockDetail(ticker: stock.ticker))
            ) {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .fontWeight(.bold)
                if stock.sharesNum > 0 {
                    if (stock.sharesNum - 1 < 0.000001) {
                        Text(String(format: "%.2f", stock.sharesNum) + " share")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    else {
                        Text(String(format: "%.2f", stock.sharesNum) + " shares")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                else {
                    Text(stock.company)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", stock.lastPrice!))
                    .fontWeight(.bold)
                if (stock.change! < 0){
                    HStack {
                        Image(systemName: "arrow.down.right")
                            .foregroundColor(.red)
                            .padding(.trailing, 2.0)
                            .font(.system(size: 13.0))

                        Text(String(format: "%.2f", stock.change!))
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
                else if (stock.change! > 0){
                    HStack {
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.green)
                            .padding(.trailing, 2.0)
                            .font(.system(size: 13.0))

                        Text(String(format: "%.2f", stock.change!))
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
                else {
                    Text(String(format: "%.2f", stock.change!))
                        .font(.subheadline)

                }
            }
        }
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(HomeScreenData())
    }
}
