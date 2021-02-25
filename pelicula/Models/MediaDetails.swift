//
//  MediaDetails.swift
//  pelicula
//
//  Created by Dscyre Scotti on 26/01/2021.
//

import Foundation
import CodableX

protocol MediaDetails: AnyCodable {
    var details: DetailsWrapper { get }
}

struct DetailsWrapper {
    let id: Int
    let title: String
    let genres: [Genre]
    let backdrop: String?
    let poster: String?
    let overview: String
    let date: String
    let tagline: String
    let status: String?
    let recommendations: ResultList
    let similar: ResultList
    let credits: MediaCredit
    let seasons: [Season]?
}

struct MovieDetails: MediaDetails {
    @Defaultable var adult: Bool
    @Nullable var backdropPath: String?
    @Nullable var belongsToCollection: String?
    @Nullable var budget: Int?
    var genres: [Genre]
    @Nullable var homepage: String?
    var id: Int
    @Nullable var imdbID: String?
    @Nullable var originalLanguage: String?
    @Nullable var originalTitle: String?
    @Defaultable var overview: String
    @Defaultable var popularity: Double
    @Nullable var posterPath: String?
    var productionCompanies: [ProductionCompany]
    var productionCountries: [ProductionCountry]
    @Nullable var releaseDate: String?
    @Defaultable var revenue: Int
    @Defaultable var runtime: Int
    var spokenLanguages: [SpokenLanguage]
    @Nullable var status: String?
    @Defaultable var tagline: String
    var title: String
    @Defaultable var video: Bool
    @Defaultable var voteAverage: Double
    @Defaultable var voteCount: Int
    var recommendations: ResultList
    var similar: ResultList
    var credits: MediaCredit

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case recommendations
        case similar
        case credits
    }
    
    var details: DetailsWrapper {
        .init(id: id, title: title, genres: genres, backdrop: backdropPath, poster: posterPath, overview: overview, date: releaseDate.formatDate, tagline: tagline, status: status, recommendations: recommendations, similar: similar, credits: credits, seasons: nil)
    }
}

struct TVDetails: MediaDetails {
    @Nullable var backdropPath: String?
    var createdBy: [CreatedBy]
    var episodeRunTime: [Int]
    @Nullable var firstAirDate: String?
    var genres: [Genre]
    @Nullable var homepage: String?
    var id: Int
    @Defaultable var inProduction: Bool
    var languages: [String]
    @Nullable var lastAirDate: String?
    @Nullable var lastEpisodeToAir: EpisodeToAir?
    var name: String
    @Nullable var nextEpisodeToAir: EpisodeToAir?
    var networks: [Network]
    @Defaultable var numberOfEpisodes: Int
    @Defaultable var numberOfSeasons: Int
    var originCountry: [String]
    @Nullable var originalLanguage: String?
    @Nullable var originalName: String?
    @Defaultable var overview: String
    @Defaultable var popularity: Double
    @Nullable var posterPath: String?
    var productionCompanies: [Network]
    var productionCountries: [ProductionCountry]
    var seasons: [Season]
    var spokenLanguages: [SpokenLanguage]
    @Nullable var status: String?
    @Defaultable var tagline: String
    @Nullable var type: String?
    @Defaultable var voteAverage: Double
    @Defaultable var voteCount: Int
    var recommendations: ResultList
    var similar: ResultList
    var credits: MediaCredit

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case recommendations
        case similar
        case credits
    }
    
    var details: DetailsWrapper {
        .init(id: id, title: name, genres: genres, backdrop: backdropPath, poster: posterPath, overview: overview, date: firstAirDate.formatDate, tagline: tagline, status: status, recommendations: recommendations, similar: similar, credits: credits, seasons: seasons)
    }
    
}

struct CreatedBy: Codable {
    var id: Int
    @Nullable var creditID: String?
    @Nullable var name: String?
    @Nullable var gender: Int?
    @Nullable var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}


struct EpisodeToAir: Codable {
    @Nullable var airDate: String?
    var episodeNumber: Int
    var id: Int
    var name: String
    @Defaultable var overview: String
    @Nullable var productionCode: String?
    @Nullable var seasonNumber: Int?
    @Nullable var stillPath: String?
    @Defaultable var voteAverage: Double
    @Defaultable var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id, name, overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Network: Codable {
    var name: String
    var id: Int
    @Nullable var logoPath: String?
    @Nullable var originCountry: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

struct Season: Codable {
    @Nullable var airDate: String?
    var episodeCount: Int
    var id: Int
    var name: String
    @Defaultable var overview: String
    @Nullable var posterPath: String?
    var seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

struct Genre: Codable {
    var id: Int
    var name: String
}

struct ProductionCompany: Codable {
    var id: Int
    @Nullable var logoPath: String?
    var name: String
    @Nullable var originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    var iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    var iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}

struct MediaCredit: Codable {
    var cast: [Cast]
    
    var results: [Result] {
        cast.sorted(by: { $0.order < $1.order })[0..<min(15, cast.count)].map { $0.result }
    }
}

struct Cast: Resultable {
    @Defaultable var adult: Bool
    var gender: Int
    var id: Int
    @Nullable var knownForDepartment: String?
    var name: String
    @Nullable var originalName: String?
    @Defaultable var popularity: Double
    @Nullable var profilePath: String?
    @Nullable var castID: Int?
    @Nullable var character: String?
    @Nullable var creditID: String?
    var order: Int

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
    
    var result: Result {
        .init(id: id, title: name, subTitle: character, image: profilePath, type: .person)
    }
}

//struct Crew: Codable {
//    var adult: Bool
//    var gender: Int
//    var id: Int
//    var knownForDepartment: String
//    var name: String
//    var originalName: String
//    var popularity: Double
//    @Nullable var profilePath: String?
//    @Nullable var castID: Int?
//    @Nullable var character: String?
//    var creditID: String
//    @Nullable var order: Int?
//    var department: String?
//    var job: String?
//
//    enum CodingKeys: String, CodingKey {
//        case adult, gender, id
//        case knownForDepartment = "known_for_department"
//        case name
//        case originalName = "original_name"
//        case popularity
//        case profilePath = "profile_path"
//        case castID = "cast_id"
//        case character
//        case creditID = "credit_id"
//        case order, department, job
//    }
//}
