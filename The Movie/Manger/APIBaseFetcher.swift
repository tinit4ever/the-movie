//
//  APIBaseFetcher.swift
//  Film
//
//  Created by cuongnh5 on 20/10/2023.
//

import Foundation

struct APIPath {
    static let getTrendingMovie: String = "3/trending/movie/day?"
    static let getGenre: String = "3/genre/movie/list?"
}

class BaseFetcher {
    
    func getTrendingMovie(completion: @escaping (Result<[Movie], Error>) -> Void)  {
        APICaller.shared.requestAPI(url: APIPath.getTrendingMovie, responseType: MovieResponse.self) { result in
            switch result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
//
//    func getTrendingMovie(completion: @escaping (Result<[Movie], Error>) -> Void)  {
//        APICaller.shared.requestAPI(url: APIPath.getTrendingMovie, responseType: MovieResponse.self) { result in
//            switch result {
//                case .success(let data):
//                    completion(.success(data.results))
//                case .failure(let error):
//                    completion(.failure(error))
//            }
//        }
//    }
    
    func getMovieGenre(completion: @escaping (Result<[Genre], Error>) -> Void)  {
        APICaller.shared.requestAPI(url: APIPath.getGenre, responseType: GenreResponse.self) { result in
            switch result {
                case .success(let data):
                    completion(.success(data.genres))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
