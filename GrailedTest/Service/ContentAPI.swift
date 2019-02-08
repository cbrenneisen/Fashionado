//
//  ContentAPI.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/16/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation

struct ContentAPI {
    
    private static let base = "https://www.grailed.com"
    
    /**
        Use the given endpoint to create a full url string
        - parameter endpoint: The endpoint to add to the base url
    */
    static func makeURL(with endpoint: String) -> String {
        return "\(base)\(endpoint)"
    }

    //MARK: - Pre determined endpoints

    enum Endpoint: String {
        
        case articles = "articles/ios_index"
        case search = "merchandise/marquee"
        
        /**
            Creates and returns a full url by using the endpoint object
         */
        var fullURL: String {
            return "\(base)/api/\(self.rawValue)"
        }
    }
    
    //MARK: - Image functions
    
    struct Image {
        
        private static let base = "https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz"
        
        static func url(for image: String, width: Int = 100) -> String {
            let args = "rotate=deg:exif/rotate=deg:0/resize=width:\(width),fit:crop/output=format:jpg,compress:true,quality:95"
            
            return "\(base)/\(args)/\(image)"
        }
        
    }
}
