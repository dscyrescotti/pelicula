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
    
    var sessionId: String? {
        guard let value = try? storage.get("session_id") else {
            return nil
        }
        return value
    }
    
    // First time and session id expires
    private func newToken(whenDone: @escaping (Token) -> Void) {
        APIService.get(endpoint: "authentication/token/new") { (token: Token) in
            if token.success {
                whenDone(token)
            } else {
                print("[Error]: Failed to create a new token.")
            }
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
    
    func logout() {
        guard let id = sessionId else {
            return
        }
        APIService.delete(endpoint: "authentication/session", body: SessionCrediential(sessionId: id)) { (success: Success) in
            if success.success {
                print("Successfully deleted session.")
            } else {
                print("[Error]: Failed to destroy the session.")
            }
        }
    }
    
    private func newSession(requestToken: String) {
        APIService.post(endpoint: "authentication/session/new", body: TokenCrediential(requestToken: requestToken)) { (session: Session) in
            if session.success {
                do {
                    try self.storage.set(session.sessionId, key: "session_id")
                } catch (let error) {
                    print(error.localizedDescription)
                }
            } else {
                print("[Error]: Failed to create a new session.")
            }
        }
    }
    
    static var sharedInstance: UserService = .init()
    
    private init() {
        if !hasSessionId {
            login(username: "", password: "")
        } else {
            print(sessionId!)
        }
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
