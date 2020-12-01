//
//  ToastView.swift
//  StockSearch
//
//  Created by Hao Fan on 12/1/20.
//

import SwiftUI

struct Toast<Presenting>: View where Presenting: View {
    @Binding var isShowing: Bool
    let presenting: () -> Presenting
    let text: Text

    var body: some View {
        if self.isShowing{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation{
                    self.isShowing = false
                }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenting()
                VStack {
                    (self.text)
                        .font(.body)
                        
                }
                .frame(width: 300, height: 50)
                .background(Color.gray)
                .foregroundColor(Color.white)
                .cornerRadius(25)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text)
    }
}

struct ContentView: View {
    @State var showToast: Bool = false

    var body: some View {
        NavigationView {
            List(0..<100) { item in
                Text("\(item)")
            }
            .navigationBarTitle(Text("A List"), displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                withAnimation {
                    self.showToast = true
                }
            }){
                Text("Toggle toast")
            })
        }
        .toast(isShowing: $showToast, text: Text("Hello toast!"))
    }

}

struct Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
