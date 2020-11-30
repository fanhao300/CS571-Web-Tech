//
//  loadingView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/29/20.
//

import SwiftUI

struct loadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Fetching Data..")
                .font(.footnote)
                .foregroundColor(Color.gray)
                .padding(.top, 8.0)
        }
        
    }
}

struct loadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            loadingView()
            loadingView()
        }
    }
}
