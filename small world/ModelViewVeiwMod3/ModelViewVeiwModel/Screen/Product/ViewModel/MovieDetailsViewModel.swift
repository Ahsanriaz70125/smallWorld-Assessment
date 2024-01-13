//
//  MovieDetailsViewModel.swift
//  ModelViewVeiwModel
//
//  Created by Abdul Sami Sultan on 13/01/2024.
//

import Foundation

final class MovieDetialsViewModel  {
    
    var movieDetail : MovieDetail? = nil
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Clourse
    
    func fetchMovieDetials(movieId: Int){
        APIManager.shared.fetchMovieDetails(movieId: movieId) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let movieList):
                self.movieDetail = movieList
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                    self.eventHandler?(.error(error))
            }
        }
    }
}

extension MovieDetialsViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
