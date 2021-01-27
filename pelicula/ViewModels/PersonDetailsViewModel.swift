//
//  CastDetailsViewModel.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import Foundation

class PersonDetailsViewModel: ObservableObject {
    let id: Int
    let type: Results
    
    @Published var details: PersonDetails? = nil
    
    init(id: Int, type: Results) {
        self.id = id
        self.type = type
        self.loadDetails()
    }
    
    func loadDetails() {
//        var parameters: [String: Any]
        APIService.get(endpoint: "\(type)/\(id)", parameters: [:]) { [weak self] (details: PersonDetails) in
            self?.details = details
            print(details)
        }
    }
}
