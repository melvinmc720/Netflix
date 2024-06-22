//
//  MovieModel.swift
//  Netflix Clone
//
//  Created by kiana mehdiof on 5/27/24.
//

import Foundation



struct movie:Codable{
    
    let original_language:String
    let original_title:String
    let overview:String
    let poster_path:String
    let release_date:String
    let vote_count:Int
    let id:Int
}
