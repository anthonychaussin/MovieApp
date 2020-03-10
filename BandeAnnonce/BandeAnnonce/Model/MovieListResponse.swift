//
//  MovieListResponse.swift
//  BandeAnnonce
//
//  Created by  on 09/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

struct MovieListResponse: Decodable {
    let page, totalResults, totalPages: Int
    let results: [MovieResponse]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    static func transformToMovieArray(result: MovieListResponse) -> [Movie] {
        return result.results.compactMap({ movieResponse -> Movie in
            try! Movie(data: movieResponse)
        })
    }
}
