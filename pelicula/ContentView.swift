//
//  ContentView.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userService: UserService = .sharedInstance
    var body: some View {
        if let _ = userService.sessionId {
            NavigationView {
                HomeView()
                    .toSearchView()
                    .navigationBarItems(leading: Button(action: {
                        UserService.sharedInstance.unauthenticate()
                    }) {
                        Text("Logout")
                    })
                    .navigationTitle("pelicula")
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
