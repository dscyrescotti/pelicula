//
//  User.swift
//  pelicula
//
//  Created by Dscyre Scotti on 29/01/2021.
//

import Foundation

struct Token: Codable {
    var success: Bool
    var expiresAt: String
    var requestToken: String
    enum CodingKeys: String, CodingKey {
        case success, expiresAt = "expires_at", requestToken = "request_token"
    }
}

struct Session: Codable {
    var success: Bool
    var sessionId: String
    enum CodingKeys: String, CodingKey {
        case success, sessionId = "session_id"
    }
}

struct Success: Codable {
    var success: Bool
}
