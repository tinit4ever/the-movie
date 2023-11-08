//
//  Movie.swift
//  Film
//
//  Created by cuongnh5 on 20/10/2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie  {
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let originalLanguage: String?
    let posterPath: String?
    let backdropPath: String?
    let popularity: Double?
    let genreIds: [Int]?
}

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case popularity
        case genreIds = "genre_ids"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        popularity = try container.decode(Double.self, forKey: .popularity)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
    }
}
