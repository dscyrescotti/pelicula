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
        NavigationView {
            HomeView()
                .navigationTitle("pelicula")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
