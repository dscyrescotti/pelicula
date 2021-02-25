//
//  UserService.swift
//  pelicula
//
//  Created by Dscyre Scotti on 29/01/2021.
//

import Foundation
import KeychainAccess
import Alamofire

final class UserService: ObservableObject {
    
    private var storage: Keychain = .init(service: "com.dscyrescotti.pelicula")
    
    var hasSessionId: Bool {
        guard let _ = try? storage.get("session_id") else {
            return false
        }
        return true
    }
    
    @Published var sessionId: String? = nil
    
    private func loadSessionId() {
        if let value = try? storage.get("session_id") {
            self.sessionId = value
        }
    }
    
    func authenticate(username: String, password: String, errorCallback: ((ErrorResponse?) -> Void)? = nil, successCallback: (() -> Void)? = nil) {
        newToken { token in
            let credientials = UserCrediential(username: username, password: password, requestToken: token.requestToken)
            print(credientials)
            APIService.post(endpoint: "authentication/token/validate_with_login", body: credientials, callback: { (_token: Token) in
                if _token.success {
                    self.newSession(requestToken: _token.requestToken, errorCallback: errorCallback)
                }
            }, errorCallback: errorCallback)
        }
    }
    
    private func newToken(whenDone: @escaping (Token) -> Void) {
        APIService.get(endpoint: "authentication/token/new") { (token: Token) in
            if token.success {
                whenDone(token)
            }
        }
    }
    
    private func newSession(requestToken: String, errorCallback: ((ErrorResponse?) -> Void)?, successCallback: (() -> Void)? = nil) {
        APIService.post(endpoint: "authentication/session/new", body: TokenCrediential(requestToken: requestToken), callback: { (session: Session) in
            if session.success {
                do {
                    try self.storage.set(session.sessionId, key: "session_id")
                    self.loadSessionId()
                    successCallback?()
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }, errorCallback: errorCallback)
    }
    
    func unauthenticate() {
        guard let id = sessionId else {
            return
        }
        APIService.delete(endpoint: "authentication/session", body: SessionCrediential(sessionId: id)) { (success: Success) in
            if success.success {
                print("Successfully deleted session.")
                try? self.storage.remove("session_id")
                self.sessionId = nil
            } else {
                print("[Error]: Failed to destroy the session.")
            }
        }
    }
    
    static var sharedInstance: UserService = .init()
    
    private init() {
        loadSessionId()
    }
    
    private struct UserCrediential: Codable {
        var username: String
        var password: String
        var requestToken: String
        enum CodingKeys: String, CodingKey {
            case username, password, requestToken = "request_token"
        }
    }

    private struct TokenCrediential: Codable {
        var requestToken: String
        enum CodingKeys: String, CodingKey {
            case requestToken = "request_token"
        }
    }
    
    private struct SessionCrediential: Codable {
        var sessionId: String
        enum CodingKeys: String, CodingKey {
            case sessionId = "session_id"
        }
    }
}
