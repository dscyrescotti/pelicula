//
//  View+.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import SwiftUI
import LazyViewSwiftUI

extension View {
    func toDetailsView(result: Result) -> some View {
        NavigationLink(destination: LazyView(destination(result: result))) {
            self
        }.buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private func destination(result: Result) -> some View {
        if result.type == .movie || result.type == .tv {
            MediaDetailsView(id: result.id, type: result.type)
                .navigationTitle(result.title)
        } else if result.type == .person {
            PersonDetailsView(id: result.id, type: result.type)
                .navigationTitle(result.title)
        } else {
            Text("Oop!")
        }
    }
    
    func toSearchView() -> some View {
        let trailing = NavigationLink(destination: LazyView(SearchView())) {
            SwiftUI.Image(systemName: "magnifyingglass")
        }.buttonStyle(PlainButtonStyle())
        return self.navigationBarItems(trailing: trailing)
    }
}
