//
//  peliculaApp.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/01/2021.
//

import SwiftUI

@main
struct peliculaApp: App {
    @ObservedObject var userService: UserService = .sharedInstance
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
