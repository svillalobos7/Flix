//
//  MovieClient.swift
//  Flix
//
//  Created by Stephanie on 11/30/18.
//  Copyright © 2018 Stephanie Villalobos. All rights reserved.
//

import Foundation

class MovieClient {
    
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let api_key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    // Make a network request to fetch movies
    func getNowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        // Create URL and URL request
        let url = URL(string: MovieClient.baseURL + "now_playing?api_key=\(MovieClient.api_key)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        // This will run when the network request returns
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                let movies = Movie.convertDictionaryToMovie(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
