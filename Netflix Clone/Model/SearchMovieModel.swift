//
//  SearchMovieModel.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 6/4/24.
//

import Foundation

struct SearchMovieModel:Codable{
    
    let results:[movie]
}

/*
 page = 1;
 results =     (
             {
         adult = 0;
         "backdrop_path" = "/zVDJ4cRgSpHlILSm7kGiklHQ6O7.jpg";
         "genre_ids" =             (
             16,
             35,
             12,
             28
         );
         id = 1062807;
         "original_language" = ja;
         "original_title" = "\U5287\U5834\U7248 SPY\U00d7FAMILY CODE: White";
         overview = "While under the guise of taking his family on a weekend winter getaway, Loid's attempt to make progress on his current mission Operation Strix proves difficult when Anya mistakenly gets involved and triggers events that threaten world peace.";
         popularity = "203.083";
         "poster_path" = "/xlIQf4y9eB14iYzNN142tROIWON.jpg";
         "release_date" = "2023-12-22";
         title = "SPY x FAMILY CODE: White";
         video = 0;
         "vote_average" = "6.467";
         "vote_count" = 196;
     },
 */
