//
//  APIManager.swift
//  ModelViewVeiwModel
//
//  Created by Ahsan Riaz on 07/08/2023.
//

//import UIKit
import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network( Error?)
}

typealias Handler = (Result<Data, DataError>) -> Void

final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    private func request(url:String,completion: @escaping Handler){
        guard let url = URL(string:  url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data  , error == nil else {
                
                completion(.failure(.invalidData))
                return }
            
            guard let response = response  as? HTTPURLResponse , 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }

            completion(.success(data))
        }.resume()
    }
    func fetchMovieList(completion: @escaping (Result<[Movies], DataError>) -> Void) {
        
        request(url: Constant.API.moviesURL) { response in
            switch response{
            case .failure(let err):
                completion(.failure(err))
            case.success(let data):
                do {
                    let list = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    CacheManager.shared.addData(data: data, url: Constant.API.moviesURL)
                    completion(.success(list.moviesList ?? []))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            }
        }
    }
    func fetchMovieDetails(movieId:Int,completion: @escaping (Result<MovieDetail, DataError>) -> Void) {
        let url = String(format: Constant.API.movieDetailsURL, movieId)
        print(url)
        if let data = CacheManager.shared.getData(url: url),let obj = try? JSONDecoder().decode(MovieDetail.self, from: data){
            completion(.success(obj))
        }else{
            request(url: url) { response in
                switch response{
                case .failure(let err):
                    completion(.failure(err))
                case.success(let data):
                    do {
                        let obj = try JSONDecoder().decode(MovieDetail.self, from: data)
                        CacheManager.shared.addData(data: data, url: url)
                        completion(.success(obj))
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                }
            }
        }

    }
    
}

/*
 
 class A : APIManager {
 
 override func temp () {
 
   }
 }
 
 */
 
// Singleten capital S ko khete hain  Singleten ka object create nai hoga
// singleten small s ko khete hain singleten ka object create hoga.
// final - inheritance ni hoga ..



