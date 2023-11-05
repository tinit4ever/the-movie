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

struct Movie: Codable {
    let id: Int
    let original_title: String?
//    let name: String?
    let overview: String?
    let original_language: String?
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Double
    let genre_ids: [Int]
}

