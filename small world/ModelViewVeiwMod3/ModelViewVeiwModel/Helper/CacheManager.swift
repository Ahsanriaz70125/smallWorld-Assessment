//
//  CoreDataManager.swift
//  ModelViewVeiwModel
//
//  Created by Abdul Sami Sultan on 12/01/2024.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()
    let cache = NSCache<NSString, NSData>()
    private init() {
        cache.countLimit = 200
        cache.totalCostLimit = 20_000_000
    }
    
    
    func addData(data:Data, url:String){
        cache.setObject(data as NSData, forKey: url as NSString)
    }
    func getData(url:String) -> Data?{
        if let obj = cache.object(forKey: url as NSString) {
            return obj as Data
        }else{
            return nil
        }
    }
    func addMovieDetails(object:MovieDetail, url:String){
        let cache = NSCache<NSString, MovieDetail>()
        cache.setObject(object, forKey: url as NSString)
    }

    func fetchMovieList(url:String) -> MoviesResponse?{
        let cache = NSCache<NSString, MoviesResponse>()
        if let obj = cache.object(forKey: url as NSString) {
            return obj
        }else{
            return nil
        }
    }
    
    
    func fetchMovieDetails(url:String) -> MovieDetail?{
        let cache = NSCache<NSString, MovieDetail>()
        if let obj = cache.object(forKey: url as NSString) {
            return obj
        }else{
            return nil
        }
    }
    
}
