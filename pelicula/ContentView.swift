//
//  ContentView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
                .toSearchView()
                .navigationTitle("pelicula")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
