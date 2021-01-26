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
    
}
