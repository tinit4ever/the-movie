//
//  Genre.swift
//  Film
//
//  Created by cuongnh5 on 23/10/2023.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String?
}
