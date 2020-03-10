//
//  Movie.swift
//  BandeAnnonce
//
//  Created by  on 03/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

/// Movie struct
public struct Movie {
    var id: Int
    var movieTitle: String
    var subTitle: String
    var poster: String
    let basePath: String = "https://image.tmdb.org/t/p/w200"
    var duration: Int
    var outDate: String
    var resum: String
    var cat: [Genre]? = nil
    var backdropPath: String
    var urlVideo: String
    
    /// Transform a MovieResponse into Movie object
    /// - Parameter data: One object of type MovieResponse
    init(data: MovieResponse) throws {
        self.id = data.id!
        self.movieTitle = data.title ?? ""
        self.poster = (data.posterPath != nil) ? "\(self.basePath)\(data.posterPath!)" : ""
        self.resum = (data.overview == nil || data.overview == "") ? "..." : data.overview!
        self.outDate = data.releaseDate ?? ""
        self.subTitle = (data.title != data.originalTitle || data.originalTitle != nil) ? "(\(String(describing: data.originalTitle!)))" : ""
        self.backdropPath = (data.backdropPath != nil) ? "\(self.basePath)\(data.backdropPath!)" : self.poster
        self.cat = data.genres
        self.urlVideo = "https://www.youtube.com/watch?v=\(String(describing: data.videos?.results?.first?.key ?? ""))"
        self.duration = data.runtime ?? 0
    }
    
    /// Constructor
    /// - Parameters:
    ///   - movieTitle: The title of movie
    ///   - poster: The poster movie
    ///   - duration: The total movie duration
    ///   - outDate: The date of movie was published
    ///   - resum: E short resum of movie
    ///   - cat: All cat of movie
    init(movieTitle: String, poster: String, duration: Int, outDate: String, resum: String, cat: [Genre]) {
        self.movieTitle = movieTitle
        
        if poster.contains("placeholder") || poster == "" {
            self.poster = poster
        }
        else{
            self.poster = "\(self.basePath)\(poster)"
        }
        
        self.duration = duration
        self.outDate = outDate
        self.resum = resum
        self.cat = cat
        self.backdropPath = self.poster
        self.urlVideo = ""
        self.id = 0
        self.subTitle = movieTitle
    }
    
    /// Generate a fake data for a movie
    public static func getFakeData() ->Movie{
        let indexTab: Int = Int.random(in: 0...4)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        //Use for testing nil image return
        //let poster: String = Bool.random() ? "https://via.placeholder.com/\(Int32.random(in: 25...2500))" : ""
        
        let poster: String = "https://via.placeholder.com/\(Int32.random(in: 25...2500))"
        var cat: [Genre] = []
        for i in 1...UInt8.random(in: 1...8){
            cat.append(Genre(id: Int(i), name: Env.bddCat[Int.random(in: 1...8)]))
        }
        return Movie.init(
            movieTitle: Env.bddName[indexTab],
            poster: poster,
            duration: Int.random(in: 0...180),
            outDate: formatter.string(from: (Date.init().addingTimeInterval(TimeInterval.random(in: -200...200)*1000000))),
            resum: Env.bddResum[indexTab],
            cat: cat)
    }
}
