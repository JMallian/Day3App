//
//  FlickrAPI.swift
//  Day3
//
//  Created by Jessica Mallian on 4/18/19.
//  Copyright © 2019 Jessica Mallian. All rights reserved.
//

import Foundation

/// specifies endpoints on the Flickr server
enum Method: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

// this struct will contain all of the knowledge that is specific to the Flickr API
struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    
    static var interestingPhotosURL: URL {
        return flickrURL(method: .interestingPhotos, parameters: ["extras": "url_h,date_taken"])
    }
    
    private static func flickrURL(method: Method, parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": API.apiKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
}
