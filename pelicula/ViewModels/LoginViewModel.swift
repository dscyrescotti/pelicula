//
//  LoginViewModel.swift
//  pelicula
//
//  Created by Dscyre Scotti on 30/01/2021.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var error: ErrorResponse? = nil
    @Published var isLogging: Bool = false
    
    func login() {
        error = nil
        isLogging = true
        UserService.sharedInstance.authenticate(username: username, password: password, errorCallback: { error in
            self.error = error
            self.isLogging = false
        }, successCallback: {
            self.isLogging = false
        })
    }
    
    func validate() -> Bool {
        username.isNotEmpty && password.isNotEmpty
    }
}
