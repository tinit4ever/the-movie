//
//  HomeControllerViewModel.swift
//  Film
//
//  Created by cuongnh5 on 20/10/2023.
//

import Foundation

protocol HomeControllerViewModelProtocol {
    func getMovie(onSuccess: @escaping () -> Void) 
    
    var movies: [Movie] {get set}
}

class HomeControllerViewModel {
    let baseFetcher: BaseFetcher?
    
    var movies: [Movie] = []
    
    init(baseFetcher: BaseFetcher) {
        self.baseFetcher = baseFetcher
    }
    
}

extension HomeControllerViewModel:  HomeControllerViewModelProtocol {
    
    func getMovie(onSuccess: @escaping () -> Void) {
        baseFetcher?.getTrendingMovie(completion: { response in
            switch response {
                case .success(let data):
                    self.getMovieSuccess(data: data)
                    onSuccess()
                case .failure(let error):
                    self.getMovieFail(error: error)
            }
        })
    }
    
    private func getMovieSuccess(data: [Movie]) {
        data.forEach { entity in
            let movie = Movie(
                id: entity.id,
                originalTitle: entity.originalTitle,
                overview: entity.overview,
                originalLanguage: entity.originalLanguage,
                posterPath: "https://image.tmdb.org/t/p/w500\(entity.posterPath!)",
                backdropPath: "https://image.tmdb.org/t/p/w500\(entity.backdropPath!)",
                popularity: entity.popularity,
                genreIds: entity.genreIds)
            movies.append(movie)
        }
    }
    
    private func getMovieFail(error: Error) {
        print("ERROR")
    }
}
