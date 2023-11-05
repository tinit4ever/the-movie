//
//  MovieDetailsViewModel.swift
//  Film
//
//  Created by cuongnh5 on 23/10/2023.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func getGenre(completion: @escaping () -> Void)
    var genres: [Genre] {get set}
}

class MovieDetailsViewModel {
    let baseFetcher: BaseFetcher?
    
    var genres: [Genre] = []
    
    init(baseFetcher: BaseFetcher) {
        self.baseFetcher = baseFetcher
    }
    
}

extension MovieDetailsViewModel:  MovieDetailsViewModelProtocol {
    
    func getGenre(completion: @escaping () -> Void) {
        baseFetcher?.getMovieGenre(completion: { response in
            switch response {
                case .success(let data):
                    self.getGenreSuccess(data: data)
                case .failure(let error):
                    self.getGenreSuccess(error: error)
            }
            completion()
        })
    }
    
    private func getGenreSuccess(data: [Genre]) {
        data.forEach { entity in
            genres.append(entity)
        }
    }
    
    private func getGenreSuccess(error: Error) {
        print("ERROR")
    }
}

