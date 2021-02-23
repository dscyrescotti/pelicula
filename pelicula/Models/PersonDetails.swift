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
    var images: Images

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
        case images
    }
    
    var age: Int? {
        if birthday != nil {
            return deathday.year - birthday.year
        }
        return nil
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

struct Images: Codable {
    var profiles: [Profile]
}

struct Profile: Codable, Identifiable, Hashable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String {
        filePath
    }
    
    @Defaultable var aspectRatio: Double
    var filePath: String
    var height: Int
    @Defaultable var voteAverage: Double
    @Defaultable var voteCount: Int
    var width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
