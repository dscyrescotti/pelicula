//
//  PersonDetails.swift
//  pelicula
//
//  Created by Dscyre Scotti on 27/01/2021.
//

import Foundation
import CodableX

struct PersonDetails: Codable {
    var birthday, knownForDepartment: String
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
    }
}
