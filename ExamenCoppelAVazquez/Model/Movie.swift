//
//  Movie.swift
//  ExamenCoppelAVazquez
//
//  Created by MacBookMBA3 on 11/11/22.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    }
    struct BelongsToCollection: Codable {
        let id: Int
        let name, posterPath, backdropPath: String
    }
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    struct ProductionCompany: Codable {
        let id: Int
        let logoPath: String
        let name, originCountry: String
    }
    struct ProductionCountry: Codable {
        let iso3166_1, name: String
    }
