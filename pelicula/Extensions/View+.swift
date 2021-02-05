//
//  View+.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import SwiftUI
import LazyViewSwiftUI

extension View {
    @ViewBuilder
    func toDetailsView(result: Result) -> some View {
        NavigationLink(destination: LazyView(destination(result: result))) {
            self
        }.buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private func destination(result: Result) -> some View {
        switch result.type {
        case .movie, .tv:
            MediaDetailsView(id: result.id, type: result.type)
                .navigationTitle(result.title)
        case .person:
            PersonDetailsView(id: result.id, type: result.type)
                .navigationTitle(result.title)
        }
    }
    
    func toSearchView() -> some View {
        let trailing = NavigationLink(destination: LazyView(SearchView())) {
            SwiftUI.Image(systemName: "magnifyingglass")
        }.buttonStyle(PlainButtonStyle())
        return self.navigationBarItems(trailing: trailing)
    }
}
