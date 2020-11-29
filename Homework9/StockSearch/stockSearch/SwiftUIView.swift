//
//  SwiftUIView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/25/20.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!").padding()
                .navigationTitle("SwiftUI")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Press Me") {
                            print("Pressed")
                        }
                    }
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
