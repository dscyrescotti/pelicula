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
            print("[Info]: Found the session id in keychain.")
        } else {
            print("[Info]: No session id in keychain.")
        }
    }
    
    func login(username: String, password: String) {
        newToken { token in
            let credientials = UserCrediential(username: username, password: password, requestToken: token.requestToken)
            print(credientials)
            APIService.post(endpoint: "authentication/token/validate_with_login", body: credientials) { (_token: Token) in
                if _token.success {
                    self.newSession(requestToken: _token.requestToken)
                } else {
                    print("[Error]: Failed to validate token.")
                }
            }
        }
    }
    
    private func newToken(whenDone: @escaping (Token) -> Void) {
        APIService.get(endpoint: "authentication/token/new") { (token: Token) in
            if token.success {
                whenDone(token)
            } else {
                print("[Error]: Failed to create a new token.")
            }
        }
    }
    
    private func newSession(requestToken: String) {
        APIService.post(endpoint: "authentication/session/new", body: TokenCrediential(requestToken: requestToken)) { (session: Session) in
            if session.success {
                do {
                    try self.storage.set(session.sessionId, key: "session_id")
                    self.loadSessionId()
                } catch (let error) {
                    print(error.localizedDescription)
                }
            } else {
                print("[Error]: Failed to create a new session.")
            }
        }
    }
    
    func logout() {
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
