//
//  APIcaller.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/27/24.
//

import Foundation
import UIKit



class APIcaller{
    static let shared = APIcaller()
    
    enum URLMETHOD:String{
        case GET
        case POST
        case UPDATE
        case DELETE
    }
    
    enum APIError:String, Error{
        
        case FetchingDataError
    }
    
    struct Constents{
        static let API_KEY:String = "11be67b9c19c1ce506286ac296cf26f9"
        static let API_ACCESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMWJlNjdiOWMxOWMxY2U1MDYyODZhYzI5NmNmMjZmOSIsInN1YiI6IjY2NTRmODIzNzIyNzllMjQxZjFiYmYwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bOQ3WEasRxflHPNy4Oq2NJkUOJY3ZoV_zVDy8vCdNPo"
        
        static let YOUTUBE_API_KEY = "AIzaSyD8xAIw0stvEcBi4hcCxbirYkWpoiRaX18"
    }
    
    public func createRequest(url:URL? , METHOD:URLMETHOD , completion:@escaping (URLRequest) -> Void){
        
        guard let url = url else {
            fatalError("URL does not exist")

        }
        
        var request = URLRequest(url: url)
        request.httpMethod = METHOD.rawValue
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMWJlNjdiOWMxOWMxY2U1MDYyODZhYzI5NmNmMjZmOSIsInN1YiI6IjY2NTRmODIzNzIyNzllMjQxZjFiYmYwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bOQ3WEasRxflHPNy4Oq2NJkUOJY3ZoV_zVDy8vCdNPo"
        ]
        
        completion(request)
        
    }
    
    
    public func FetchTopRatedMovie(completion:@escaping (Result<topratedmovieModel , APIError>) -> Void){
        
        createRequest(url: URL(string: "https://api.themoviedb.org/3/movie/top_rated"), METHOD: .GET, completion: { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data , error == nil else {
                    print("Could not read data, try again(TopRatedMovie)")
                    completion(.failure(.FetchingDataError))
                    return
                }
                
                do{
                    let response = try JSONDecoder().decode(topratedmovieModel.self, from: data)
                    completion(.success(response))
                }
                
                catch{
                
                    completion(.failure(.FetchingDataError))
                }
            }
            task.resume()
            
        })
    }
    
    public func FetchPopularMovie(completion:@escaping (Result<popularmovieModel , APIError>) -> Void){
        createRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular"), METHOD: .GET, completion: { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data , error == nil else {
                    print("Could not read data, try again(TopRatedMovie)")
                    return
                }
                
                do{
                    let response = try JSONDecoder().decode(popularmovieModel.self, from: data)
                    completion(.success(response))
                }
                
                catch{
                    print("Error")
                }
            }
            task.resume()
            
        })
    }
    
    public func FetchUpcomingMovie(completion:@escaping (Result<upcomingmovieModel , APIError>) -> Void){
        createRequest(url: URL(string: "https://api.themoviedb.org/3/movie/upcoming"), METHOD: .GET, completion: { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data , error == nil else {
                    print("Could not read data, try again(TopRatedMovie)")
                    return
                }
                
                do{
                    let response = try JSONDecoder().decode(upcomingmovieModel.self, from: data)
                    completion(.success(response))
                }
                
                catch{
                    print("Error")
                }
            }
            task.resume()
            
        })
    }
    
    public func FetchNowplayingMovie(completion:@escaping (Result<nowplayingmovieModel , APIError>) -> Void){
        createRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing"), METHOD: .GET, completion: { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data , error == nil else {
                    print("Could not read data, try again(TopRatedMovie)")
                    return
                }
                
                do{
                    let response = try JSONDecoder().decode(nowplayingmovieModel.self, from: data)
                    completion(.success(response))
                }
                
                catch{
                    print("Error")
                }
            }
            task.resume()
            
        })
    }
    
    // -MARK: SEARCH MOVIE
    public func SearchMovie(movie:String , completion: @escaping (Result<SearchMovieModel , APIError>) -> Void){
        
        guard let movie = movie.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        createRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constents.API_KEY)&query=\(movie)"), METHOD: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data  = data , error == nil else {
                    fatalError("you got an error while searching movie")
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchMovieModel.self, from: data)
                    completion(.success(result))
                }
                
                catch{
                    completion(.failure(APIError.FetchingDataError))
                }
            }
            task.resume()
        }
    }
    
    public func fetchMostDiscoverMovie(completion: @escaping (Result<MostDiscoverMovieModel , APIError>) -> Void ){
        
        createRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"), METHOD: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, Response, error in
                
                guard let data = data , error == nil else {
                    completion(.failure(APIError.FetchingDataError))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(MostDiscoverMovieModel.self, from: data)
                    completion(.success(result))
                }
                
                catch{
                    completion(.failure(APIError.FetchingDataError))
                }
                
            }
            task.resume()
            
        }
        
    }
    
    
    public func DownloadMovie( Media_ID:Int,completion: @escaping (Result<String,Error>) -> Void) {
        createRequest(url: URL(string: "https://api.themoviedb.org/3/account/21293404/watchlist"), METHOD: .POST) { request in
            
            var Request = request
            
            let parameters = [
              "media_type": "movie",
              "media_id": Media_ID,
              "watchlist": true
            ] as [String : Any?]
            
            Request.allHTTPHeaderFields =  [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMWJlNjdiOWMxOWMxY2U1MDYyODZhYzI5NmNmMjZmOSIsInN1YiI6IjY2NTRmODIzNzIyNzllMjQxZjFiYmYwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bOQ3WEasRxflHPNy4Oq2NJkUOJY3ZoV_zVDy8vCdNPo"
              ]
            
            
            do{
                let PostData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                Request.httpBody = PostData
            }
            catch{
                print("you got an error while downloading movie")
            }
            
            
            
            
            let task = URLSession.shared.dataTask(with: Request) { data , response, error in
                guard let data = data , error == nil else {
                    return
                }
                
                do{
                    completion(.success("success"))
                }
                
                catch{
            
                    completion(.failure(error))
                }
            }
            
            task.resume()
         
        }
    }
    
    public func GetWatchListMovies(completion: @escaping (Result<MyWatchListModel,APIError>) -> Void){
        
        createRequest(url: URL(string: "https://api.themoviedb.org/3/account/21293404/watchlist/movies"), METHOD: .GET) { request  in
            
            let task = URLSession.shared.dataTask(with: request) { data, response , error  in
                guard let data = data , error == nil else {
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(MyWatchListModel.self, from: data)
                    completion(.success(result))
                }
                
                catch{
                    completion(.failure(APIError.FetchingDataError))
                }
            }
            task.resume()
        }
    }
    
    
    public func YoutubeVideo(_ MovieName:String , completion: @escaping () -> Void){
        guard let query = MovieName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        createRequest(url: URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(Constents.YOUTUBE_API_KEY)"), METHOD: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data , error == nil else {
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                }
                
                catch{
                    print("can not read data from Youtube")
                }
                
                
            }
            task.resume()
        }
    }
    
}
