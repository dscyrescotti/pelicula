//
//  ErrorService.swift
//  pelicula
//
//  Created by Dscyre Scotti on 30/01/2021.
//

import Foundation

final class ErrorService: ObservableObject {
    @Published var isPresented = false
    
    static var sharedInstance: ErrorService = .init()
    
    func showToast() {
        isPresented.toggle()
    }
    
    private init() { }
}
