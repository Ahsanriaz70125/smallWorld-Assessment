//
//  Constant.swift
//  ModelViewVeiwModel
//
//  Created by Ahsan Riaz on 07/08/2023.
//

enum Constant {
    private enum SecretKeys{
        static let apiKey = "97852f38a9cacab04d8b0d31701a5bef"
    }
    enum API {
        static let productURl  = "https://fakestoreapi.com/products"
        static let moviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(SecretKeys.apiKey)"
        static let movieDetailsURL = "https://api.themoviedb.org/3/movie/%d?api_key=97852f38a9cacab04d8b0d31701a5bef"
    }
}
