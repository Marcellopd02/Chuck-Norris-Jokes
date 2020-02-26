//
//  Joke.swift
//  Chuck Norris
//
//  Created by Marcello Pontes Domingos on 24/01/20
//

import Foundation

struct Joke: Codable {
    var icon_url: String
    var value: String
    
    init(json: [String: Any]) {
        value = json["value"] as? String ?? ""
        icon_url = json["icon_url"] as? String ?? ""
    }
   
}

struct Jokes: Codable {
    let result: [Joke]
}
