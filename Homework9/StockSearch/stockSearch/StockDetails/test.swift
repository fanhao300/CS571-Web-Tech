//
//  test.swift
//  StockSearch
//
//  Created by Hao Fan on 12/1/20.
//

import SwiftUI

struct test: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("news.source")
                Text("news.elapsedTime")
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.top, 5)
            
            Text("news.title")
                .font(.headline)
                .frame(height: 70, alignment: .topLeading)
                .padding(.bottom, 5)
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
