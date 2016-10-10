//
//  Configuration.swift
//  TMDB
//
//  Created by Георгий Кажуро on 07.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import Foundation

class Configuration {
    static let instance = Configuration()
    
    fileprivate var _baseUrl: String!
    fileprivate var _secureBaseUrl: String!
    fileprivate var _backdropSizes: [String]!
    fileprivate var _logoSizes: [String]!
    fileprivate var _posterSizes: [String]!
    fileprivate var _profileSizes: [String]!
    fileprivate var _stillSizes: [String]!
    fileprivate var _genres = [Int:String]()
    
    fileprivate let _API_KEY = "33cc3e142714fd03168b364ab92aaccf"
    
    var baseUrl: String {
        return _baseUrl
    }
    
    var secureBaseUrl: String {
        return _secureBaseUrl
    }
    
    var backdropSizes: [String] {
        return _backdropSizes
    }
    
    var logoSizes: [String] {
        return _logoSizes
    }
    
    var posterSizes: [String] {
        return _posterSizes
    }
    
    var profileSizes: [String] {
        return _profileSizes
    }
    
    var stillSizes: [String] {
        return _stillSizes
    }
    
    var genres: [Int:String] {
        return _genres
    }
    
    var API_KEY: String {
        return _API_KEY
    }
    
    func createConfiguration() {
        let session = URLSession.shared
        
        let confUrlString = "https://api.themoviedb.org/3/configuration?api_key=\(_API_KEY)"
        
        if let confUrl = URL(string: confUrlString) {
            session.dataTask(with: confUrl, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] {
                            if let config = json["images"] as? [String:AnyObject] {
                                self._baseUrl = config["base_url"] as? String
                                self._secureBaseUrl = config["secure_base_url"] as? String
                                self._backdropSizes = config["backdrop_sizes"] as? [String]
                                self._logoSizes = config["logo_sizes"] as? [String]
                                self._posterSizes = config["poster_sizes"] as? [String]
                                self._profileSizes = config["profile_sizes"] as? [String]
                                self._stillSizes = config["still_sizes"] as? [String]
                            }
                        }
                    } catch {
                    print("Could not serialize json")
                }
                }
            }).resume()
        }
        
        let genresUrlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(_API_KEY)"
        
        if let genresUrl = URL(string: genresUrlString) {
            session.dataTask(with: genresUrl, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] {
                            if let genresList = json["genres"] as? [[String:AnyObject]] {
                                for genre in genresList {
                                    if let genre_id = genre["id"] as? Int, let genre_name = genre["name"] as? String {
                                        self._genres[genre_id] = genre_name
                                    }
                                }
                            }
                        }
                    } catch {
                        print("Could not serialize json")
                    }

                }
            }).resume()
        }
    }
    
}
