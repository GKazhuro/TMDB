//
//  Movie.swift
//  TMDB
//
//  Created by Георгий Кажуро on 07.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import Foundation

class Movie {
    fileprivate var _adult : Bool!
    fileprivate var _backdropPaths: [String:String]!
    fileprivate var _genreStrings: [String]!
    fileprivate var _id: Int!
    fileprivate var _overview: String!
    fileprivate var _releaseDate: String!
    fileprivate var _posterPaths: [String:String]!
    fileprivate var _popularity: Double!
    fileprivate var _title: String!
    fileprivate var _voteAverage: Double!
    fileprivate var _voteCount: Int!
    
    var adult: Bool {
        return _adult
    }

    var backdropPaths: [String:String] {
        return _backdropPaths
    }
    
    var genreStrings: [String] {
        return _genreStrings
    }
    
    var id: Int {
        return _id
    }
    
    var overview: String {
        return _overview
    }
    
    var releaseDate: String {
        return _releaseDate
    }
    
    var posterPaths: [String:String] {
        return _posterPaths
    }
    
    var popularity: Double {
        return _popularity
    }
    
    var title: String {
        return _title
    }
    
    var voteAverage: Double {
        return _voteAverage
    }
    
    var voteCount: Int {
        return _voteCount
    }
    
    func createFullBackdropPaths(_ shortPath: String!) -> [String:String]!{
        var fullPaths = [String:String]()
        if let shortPath = shortPath {
            for size in Configuration.instance.backdropSizes {
                fullPaths[size] = "\(Configuration.instance.secureBaseUrl)\(size)\(shortPath)"
            }
        }
        return fullPaths
    }
    
    func createFullPosterPaths(_ shortPath: String!) -> [String:String]!{
        var fullPaths = [String:String]()
        if let shortPath = shortPath {
            for size in Configuration.instance.posterSizes {
                fullPaths[size] = "\(Configuration.instance.secureBaseUrl)\(size)\(shortPath)"
            }
        }
        return fullPaths
    }
    
    func getGenresStrings (_ genresIds: [Int]!) -> [String] {
        var genresStrings = [String]()
        if let genresIds = genresIds {
            for id in genresIds {
                if let genreString = Configuration.instance.genres[id] {
                    genresStrings.append(genreString)
                }
            }
        }
        return genresStrings
    }
    
    init(movieDict: [String:AnyObject]) {
        _adult = movieDict["adult"] as? Bool
        _backdropPaths = createFullBackdropPaths(movieDict["backdrop_path"] as? String)
        _genreStrings = getGenresStrings(movieDict["genre_ids"] as? [Int])
        _id = movieDict["id"] as? Int
        _overview = movieDict["overview"] as? String
        _title = movieDict["title"] as? String
        _releaseDate = movieDict["release_date"] as? String
        _posterPaths = createFullPosterPaths(movieDict["poster_path"] as? String)
        _popularity = movieDict["popularity"] as? Double
        _voteAverage = movieDict["vote_average"] as? Double
        _voteCount = movieDict["vote_count"] as? Int
    }
}
