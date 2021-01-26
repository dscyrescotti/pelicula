//
//  MediaDetailsViewModel.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import Foundation
import CodableX

class MediaDetailsViewModel: ObservableObject {
    private struct Options: OptionConfigurable {
        static var options: [Option] = [
            .init(MovieDetails.self),
            .init(TVDetails.self)
        ]
    }
    
    let id: Int
    let type: Results
    
    init(id: Int, type: Results) {
        self.id = id
        self.type = type
        self.loadDetails()
    }
    
    func loadDetails() {
        APIService.get(endpoint: "\(type)/\(id)", parameters: [:]) { (anyable: OptionalAnyable<Options>) in
            if let details = anyable.wrappedValue {
                print(details)
            }
        }
    }
}
