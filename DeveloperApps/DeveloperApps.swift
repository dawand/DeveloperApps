//
//  DeveloperApps.swift
//  DeveloperApps
//
//  Created by Dawand Sulaiman on 10/01/2018.
//  Copyright © 2018 Kurdcode. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

public class DeveloperApps {
    
    class public func getApps(for developer:String, completionHandler: @escaping ([App]?, Error?) -> Void) {
        
        var apps = [App]()
        
        let iTunesURL = "https://itunes.apple.com/search?term=\(developer)&country=us&entity=software"
        
        guard let url = URL(string: iTunesURL) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as! [String: Any] {
                if let appsArray = json["results"] as? [[String:Any]] {
                    for appDict in appsArray {
                        if let app = try? App(json: appDict) {
                            apps.append(app)
                        }
                    }
                    completionHandler(apps, nil)
                }
            }
        }
        task.resume()
    }
}
