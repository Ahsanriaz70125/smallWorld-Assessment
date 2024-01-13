//
//  ProductViewModel.swift
//  ModelViewVeiwModel
//
//  Created by Ahsan Riaz on 09/08/2023.
//

import Foundation


final class MovieViewModel  {
    
    var movieList : [Movies] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Clourse
    var selectedId = 0
    
    func fatchProduct () {
        
        self.eventHandler?(.loading)
        APIManager.shared.fetchMovieList { response in
            self.eventHandler?(.stopLoading)
            switch response {
                
            case .success(let movieList):
                self.movieList = movieList
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func selectId(at index:Int){
        selectedId = movieList[index].id ?? 0
    }
    
}

extension MovieViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
