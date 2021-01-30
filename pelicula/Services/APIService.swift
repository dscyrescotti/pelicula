//
//  APIService.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/01/2021.
//

import Foundation
import Alamofire

final class APIService {
    private static let API_KEY = "2bd3ef300e0f952b182ebf1955bba316"
    private static let BASE_URL = "https://api.themoviedb.org/3/"
    
    static func get<T: Codable>(endpoint: String, parameters: [String: Any] = [:], callback: @escaping (T) -> Void) {
        var params = parameters
        params["api_key"] = API_KEY
        AF.request(BASE_URL + endpoint, method: .get, parameters: params).responseDecodable(of: T.self, queue: .main) { result in
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            if let value = result.value {
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }
    
    static func post<T: Codable, Body: Encodable>(endpoint: String, body: Body?, callback: @escaping (T) -> Void) {
        AF.request("\(BASE_URL)\(endpoint)?api_key=\(API_KEY)", method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: ["Content-Type":"application/json"]).validate().responseDecodable(of: T.self) { result in
            if let statusCode = result.response?.statusCode, statusCode >= 400 && statusCode < 500 {
                print(statusCode)
                ErrorService.sharedInstance.showToast()
            }
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            if let value = result.value {
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }
    
    static func delete<T: Codable, Body: Encodable>(endpoint: String, body: Body?, callback: @escaping (T) -> Void) {
        AF.request("\(BASE_URL)\(endpoint)?api_key=\(API_KEY)", method: .delete, parameters: body, encoder: JSONParameterEncoder.default, headers: ["Content-Type":"application/json"]).responseDecodable(of: T.self) { result in
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            if let value = result.value {
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }
}
