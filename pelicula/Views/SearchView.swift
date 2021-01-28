//
//  SearchView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 28/01/2021.
//

import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    @State private var selection = 1
    var body: some View {
        Group {
//            Picker(selection: $selection, label: Text(""), content: {
//                /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
//                /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
//            })
            if query.isEmpty {
                Text("Type something to explore...")
            } else {
                VStack {
                    PosterGridView(endpoint: "search/movie", params: ["query": query], type: .media, include: false)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    private let tags = ["Movie"]
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
