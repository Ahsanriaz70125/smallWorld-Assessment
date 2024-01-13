//
//  MovieDetails.swift
//  ModelViewVeiwModel
//
//  Created by Abdul Sami Sultan on 12/01/2024.
//

import Foundation
class MovieDetail : Codable {
    let id : Int?
    let overview : String?
    let popularity : Double?
    let release_date : String?
    let revenue : Int?
    let budget : Int?
    let runtime : Int?
    let title : String?
    let vote_average : Double?
    let poster_path: String?
}
