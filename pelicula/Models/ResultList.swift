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
    @ArrayAnyable<Options> var _results: [Any]
    
    enum CodingKeys: String, CodingKey {
        case page, totalResults = "total_results", totalPages = "total_pages", _results = "results"
    }
    
    struct Options: OptionConfigurable {
        static var options: [Option] = [
            .init(MovieResult.self),
            .init(TVResult.self)
        ]
    }
    
    var results: [Result] {
        _results.compactMap { $0 as? Resultable }.map { $0.result }
    }
    
}

struct MovieResult: Resultable {
    @Nullable var posterPath: String?
    @Defaultable var adult: Bool
    @Defaultable var overview: String
    @Nullable var releaseDate: String?
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
    
    var result: Result {
        .init(id: id, title: title, subTitle: releaseDate, image: posterPath!, type: .movie)
    }
}

struct TVResult: Resultable {
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
    
    var result: Result {
        .init(id: id, title: name, subTitle: firstAirDate, image: posterPath!, type: .tv)
    }
}

enum Results: String {
    case tv, movie
}

struct Result: Identifiable {
    let id: Int
    let title: String
    let subTitle: String?
    let image: String
    let type: Results
}

protocol Resultable: AnyCodable {
    var result: Result { get }
}

