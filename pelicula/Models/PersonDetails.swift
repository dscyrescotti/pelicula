//
//  PersonDetails.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import Foundation
import CodableX

struct PersonDetails: Codable {
    @Nullable var birthday: String?
    var knownForDepartment: String
    @Nullable var deathday: String?
    var id: Int
    var name: String
    var alsoKnownAs: [String]
    @Defaultable var gender: Int
    @Defaultable var biography: String
    @Defaultable var popularity: Double
    @Nullable var placeOfBirth: String?
    @Nullable var profilePath: String?
    @Defaultable var adult: Bool
    @Nullable var imdbID: String?
    @Nullable var homepage: String?
    var combinedCredits: CombinedCredit

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday, id, name
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdbID = "imdb_id"
        case homepage
        case combinedCredits = "combined_credits"
    }
}

struct CombinedCredit: Codable {
    struct Options: OptionConfigurable {
        static var options: [Option] = [
            .init(MovieResult.self),
            .init(TVResult.self)
        ]
    }
    @ArrayAnyable<Options> var _cast: [Any]
    @ArrayAnyable<Options> var _crew: [Any]
    enum CodingKeys: String, CodingKey {
        case _crew = "crew", _cast = "cast"
    }
    
    var cast: [Result] {
        _cast.compactMap { ($0 as? Resultable)?.result }
    }
}
