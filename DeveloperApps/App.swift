//
//  App.swift
//  DeveloperApps
//
//  Created by Dawand Sulaiman on 10/01/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

public struct App {
    
    public let id: Int
    public let name: String
    public let category: [String]
    public let artworkUrl: String
    public let url: String
    
    init(json: [String: Any]) throws {
        
        guard let id = json["trackId"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let name = json["trackName"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let category = json["genres"] as? [String] else {
            throw SerializationError.missing("category")
        }
        
        guard let artwork = json["artworkUrl60"] as? String else {
            throw SerializationError.missing("artwork URL")
        }
        
        guard let url = json["trackViewUrl"] as? String else {
            throw SerializationError.missing("url")
        }
        
        // Initialize properties
        self.id = id
        self.name = name
        self.category = category
        self.artworkUrl = artwork
        self.url = url
    }
}

