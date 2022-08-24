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
        VStack(spacing: 0) {
            SearchBar(query: $query)
                .padding(.vertical, 5)
            if query.isEmpty {
                Text("Type something to explore...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                VStack {
                    Picker(selection: $selection, label: Text("")) {
                        ForEach(searchs) { search in
                            Text(search.name).tag(search.id)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
                    TabView(selection: $selection) {
                        ForEach(searchs) { search in
                            PosterGridView(endpoint: search.endpoint, params: ["query": query], type: search.type, include: false).tag(search.id)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.bottom)
                    .id(query)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Explore")
    }
    private let searchs: [Search] = [.init(id: 1, name: "Movie", endpoint: "search/movie", type: .media), .init(id: 2, name: "TV", endpoint: "search/tv", type: .media)]
    private struct Search: Identifiable {
        let id: Int
        let name: String
        let endpoint: String
        let type: RowType
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
