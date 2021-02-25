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
            HomeView()
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
