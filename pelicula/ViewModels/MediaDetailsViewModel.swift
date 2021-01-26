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
    
    func loadDetails() {
        APIService.get(endpoint: "movie/475557", parameters: [:]) { (anyable: OptionalAnyable<Options>) in
            if let details = anyable.wrappedValue {
                print(details)
            }
        }
    }
}
