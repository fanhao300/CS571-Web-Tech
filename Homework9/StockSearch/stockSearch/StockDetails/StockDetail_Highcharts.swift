//
//  testView.swift
//  StockSearch
//
//  Created by Hao Fan on 11/30/20.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var title: String
    var url: URL
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil

    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(URLRequest(url: url))
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // you can access environment via context.environment here
        // Note that this method will be called A LOT
    }

    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.title = webView.title ?? ""
            parent.loadStatusChanged?(false, nil)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
    }
}

struct Highchart: View {
    @State var title: String = ""
    @State var error: Error? = nil
    var ticker: String

    var body: some View {
        WebView(title: $title, url: URL(string: "file:///Users/haofan/Desktop/CSCI%20571/Lab/Homework9/StockSearch/StockSearch/Highchart/highchart.html?ticker=\(ticker)")!)
            .onLoadStatusChanged { loading, error in
                if loading {
                    self.title = "Loading…"
                }
        }
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
//        Highchart(isFinishLoading: .constant(true))
        Highchart(ticker:"baba")
    }
}
