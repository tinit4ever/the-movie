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
            movies.append(entity)
        }
    }
    
    private func getMovieFail(error: Error) {
        print("ERROR")
    }
}
