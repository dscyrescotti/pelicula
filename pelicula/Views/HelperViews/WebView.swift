//
//  WebView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/02/2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

struct CacheWebView_Provider: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.youtube.com/embed/YdAIBlPVe9s")
    }
}
