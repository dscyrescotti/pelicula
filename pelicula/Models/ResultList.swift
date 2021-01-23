//
//  Media.swift
//  pelicula
//
//  Created by Dscyre Scotti on 23/01/2021.
//

import Foundation
import CodableX

struct ResultList: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    @ArrayAnyable<Options> var results: [Any]
    
    enum CodingKeys: String, CodingKey {
        case page, totalResults = "total_results", totalPages = "total_pages", results
    }
    
    struct Options: OptionConfigurable {
        static var options: [Option] = [
            .init(MovieResult.self),
            .init(TVResult.self)
        ]
    }
}

struct MovieResult: AnyCodable {
    @Nullable var posterPath: String?
    @Defaultable var adult: Bool
    @Defaultable var overview: String
    var releaseDate: String
    var genreIDS: [Int]
    var id: Int
    @Nullable var originalTitle: String?
    @Nullable var originalLanguage: String?
    var title:  String
    @Nullable var backdropPath: String?
    @Defaultable var popularity: Double
    @Defaultable var voteCount: Int
    @Defaultable var video: Bool
    @Defaultable var voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

struct TVResult: AnyCodable {
    @Nullable var posterPath: String?
    @Defaultable var popularity: Double
    var id: Int
    @Nullable var backdropPath: String?
    @Defaultable var voteAverage: Double
    @Defaultable var overview: String
    @Nullable var firstAirDate: String?
    var originCountry: [String]
    var genreIDS: [Int]
    @Nullable var originalLanguage: String?
    @Defaultable var voteCount: Int
    var name: String
    @Nullable var originalName: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}
