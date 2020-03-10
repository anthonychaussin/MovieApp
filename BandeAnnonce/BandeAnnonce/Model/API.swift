//
//  API.swift
//  BandeAnnonce
//
//  Created by  on 03/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

public struct API {
    
    // MARK: Properties
    public enum optionalArgument: String{
        case query = "query"
        case page = "page"
        case adult = "adult"
        case id = "_id"
        case genre = "with_genre"
    }
    
    public enum typeRequest: String{
        case movie = "movie"
        case genre = "genre"
        case search = "search"
        case mutli = "mutli"
        case discover = "discover/movie"
    }
    
    private static let APIRequestList = [
        "movie_request":
            [
                "detail": "/{movie_id}",
                "alternativeTitle": "/{movie_id}/alternative_titles",
                "imageMovies": "/{movie_id}/images",
                "tags": "/{movie_id}/keywords",
                "video": "/{movie_id}/videos",
                "similar": "/{movie_id}/similar",
                "latest": "/latest",
                "current_played": "/now_playing",
                "popular": "/popular",
                "bestRate": "/top_rated"
            ],
        "genre_request":
            [
                "movie": "/movie/list"
            ],
        "search_request":
            [
                "keyword": "/keyword",
                "keyword_optional": [ "query", "page"],
                "movie": "/movie",
                "movie_optional": [ "query", "page", "adult"],
                "multi": "/multi",
                "mutli_optional": [ "query", "page", "adult"]
            ],
        ]
    
    static let baseUrl = "https://api.themoviedb.org/3"
    
    // MARK: Function
    
    /// get base of url
    /// - Parameter type: base type
    private static func baseRequest(type: typeRequest) -> String{
        return "/\(type.rawValue)"
    }
    /// token for API
    private static func addToken() -> String {
        return urlParser(key: "token", value: Env.token, URL: "?api_key={token}")
    }
    /// Language to display content
    /// - Parameter value: iso language value (ex: fr-FR)
    private static func addLanguage(value: String = "fr-FR") -> String {
        return urlParser(key: "language", value: value, URL: "&language={language}&append_to_response=videos")
    }
    /// Parse the URL request
    /// - Parameters:
    ///   - key: Key to parse
    ///   - value: Value to replace
    ///   - URL: Url who contain key
    private static func urlParser(key: String, value: String, URL: String) ->String{
        return URL.replacingOccurrences(of: "{\(key)}", with: value)
    }
    /// Format the URL to optional parameters
    /// - Parameters:
    ///   - baseType: base type
    ///   - type: type of sub request
    ///   - options: Array of option to add at request
    private static func OptionalFormateur(baseType: String, type: String, options: [optionalArgument: String]) -> String{
        var endUrl = ""
        for (key, value) in options{
            switch key {
            case optionalArgument.query:
                endUrl += (((APIRequestList["\(baseType)_request"]! as! [String: [String: String]])["\(type)_optional"]! )[optionalArgument.query.rawValue] == key.rawValue) ? "&query=\(value)" : ""

            case optionalArgument.page:
                endUrl += (value != "") ? "&page=\(value)" : "&page=1"

            case optionalArgument.adult:
                endUrl += (((APIRequestList["\(baseType)_request"]! as! [String: [String: String]])["\(type)_optional"]! )[optionalArgument.query.rawValue] == key.rawValue) ? "&adult=\(value)" : ""
            
            case optionalArgument.id:
                endUrl += urlParser(key: "\(baseType)_id", value: value, URL: (((APIRequestList["\(baseType)_request"]! as! [String: String])["\(type)"]! )))
                
            case optionalArgument.genre:
                endUrl +=  "&with_genres=\(value)"
        }
        }
        return endUrl
    }
    /// Make the URL request for API
    /// - Parameters:
    ///   - type: base type of request
    ///   - option: eventual option of request
    ///   - arg: all argument option for request
    ///   - language: change if eventualy you not speak the biutifulest language in world
    private static func builUrlBody(type: typeRequest, option: String? = nil, arg: [optionalArgument: String]? = nil, language: String = "fr-FR") -> String {

        var query: String = ""
        var arguments: String = ""
        
        if let opt: String = option
        {
            query = (((((APIRequestList["\(type.rawValue)_request"]! as! [String: String])[opt]?.contains("{"))! ? OptionalFormateur(baseType: type.rawValue, type: opt, options: [optionalArgument.id: arg![optionalArgument.id]!]) : (APIRequestList["\(type.rawValue)_request"]! as! [String: String])[opt])!) )
        
            if (arg != nil && arg?.first!.key != optionalArgument.id){
                arguments = OptionalFormateur(baseType: type.rawValue, type: opt, options: arg!)
            }
            
        }
        else{ arguments = OptionalFormateur(baseType: type.rawValue, type: type.rawValue, options: arg!) }

        return "\(baseUrl)\(baseRequest(type: type))\(query)\(addToken())\(arguments)\(addLanguage(value: language))"
    }
    
    /// Make a API request to the movie db
    /// - Parameters:
    ///   - type: base type of request
    ///   - option: eventual option of request
    ///   - arg: all argument option for request
    ///   - language: change if eventualy you not speak the biutifulest language in world
    ///   - completionHandler: the closure function for threat data in need format
    public static func APIRequest(type: typeRequest, option: String? = nil, arg: [optionalArgument: String]? = nil, language: String = "fr-FR", completionHandler: @escaping (Data?) -> Void){

        guard let url = URL(string: builUrlBody(type: type, option: option, arg: arg, language: language)) else{
            print("the URL can not be null")
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
            guard error == nil else {
                print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }
            completionHandler(data)

        }
        requestAPI.resume()
    }
}
