//
//  ContentView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/01/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    var body: some View {
        KFImage(URL(string: "https://images.unsplash.com/photo-1610902417620-dcae662b997d?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")!)
            .cacheOriginalImage()
            .resizable()
            .frame(width: 200, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .onAppear {
                APIService.get(endpoint: "tv/popular") { (result: ResultList) in
                    print(result)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
