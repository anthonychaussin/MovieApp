//
//  MovieResponse.swift
//  BandeAnnonce
//
//  Created by  on 09/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let adult, video: Bool?
    let posterPath, overview, releaseDate, originalTitle, originalLanguage, title, backdropPath, status, tagline, homepage, imdbID: String?
    let genreIDS: [Int]?
    let id, voteCount: Int?
    let popularity, voteAverage: Double?
    let belongsToCollection: BelongsToCollection?
    let genres: [Genre]?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let revenue, runtime, budget: Int?
    let spokenLanguages: [SpokenLanguage]?
    let videos: Videos?

    enum CodingKeys: String, CodingKey {
        case adult, overview, id, title, video, status, tagline, budget, genres, homepage, revenue, runtime, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case belongsToCollection = "belongs_to_collection"
        case imdbID = "imdb_id"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
        case videos
    }
    
    public static func transformToMovieArray(result: [MovieResponse]) -> [Movie] {
        return result.compactMap({ (movieResponse) -> Movie in
            try! Movie(data: movieResponse)
        })
    }
}
