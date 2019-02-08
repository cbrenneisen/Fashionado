//
//  ContentService.swift
//  GrailedTest
//
//  Created by Cbrenneisen on 1/16/19.
//  Copyright © 2019 Carl Brenneisen. All rights reserved.
//

import Foundation
import RxSwift

class ContentService<T: Item>: ServiceInterface {
    
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    /**
        Fetch data from the server using the given url
        - parameter urlString: The full endpoint to retrieve data from
        - parameter completion: The closure to execute when the request is complete
    */
    func fetch(using urlString: String, completion: @escaping Handler){
        
        guard let url = URL(string: urlString) else {
            completion(nil, .badURL)
            return
        }
        
        // initiate request
        session.dataTask(with: url){ [weak self] data, response, error in
            // hand off response to 'process' function
            self?.process(data, response, error, completion)
            
        }.resume()
    }
    
    /**
        Handle the response from the server
        - parameter data: Data object from URLSession handler
        - parameter response: URLResponse object from URLSession handler
        - parameter error: Error object from URLSession handler
        - parameter completion: Closure to execute upon completion
    */
    private func process(_ data: Data?, _ response: URLResponse?, _ error: Error?, _ completion: Handler){
        // ensure the completion handler is always executed with the proper arguments
        var returnError: NetworkError?
        var container: ItemContainer<T>?
        defer { completion(container, returnError) }
        
        // validate error and url response
        guard validate(error: error, &returnError) else { return }
        guard validate(response: response, &returnError) else { return }
        
        // unwrap data
        guard let serverData = data else {
            print("No data returned from server")
            returnError = .data("None")
            return
        }
        
        // parse and return data
        container = parse(data: serverData, &returnError)
    }
    
    /**
        Parse the proper result from server data
        - parameter data: The data from the server
        - parameter error: The result to write to if anything goes wrong
        - returns: The properly parsed data from the server
    */
    private func parse(data: Data, _ returnError: inout NetworkError?) -> ItemContainer<T>? {
        do {
            return try decoder.decode(ItemContainer<T>.self, from: data)
        }catch {
            //TODO: more elaborate error handling
            returnError = .data("Invalid")
            return nil
        }
    }
    
    /**
     Validate that the server has not returned and erro, writing to an error object if neccessary
     - parameter response: The potential error from the server to check
     - parameter error: The error to write to if anything looks wrong
     - returns: True if there is no error, False otherwise
     */
    private func validate(error: Error?, _ returnError: inout NetworkError?) -> Bool{
        if let e = error {
            //TODO: log error
            print(e.localizedDescription)
            returnError = .server
            return false
        }
        return true
    }
    
    /**
        Validate a URL Response, writing to an error object if neccessary
        - parameter response: The URL Response to validate
        - parameter error: The error to write to if anything looks wrong
        - returns: True if the URL Response is valid, False otherwise
    */
    private func validate(response: URLResponse?, _ error: inout NetworkError?) -> Bool{
        
        guard let _ = response else {
            //TODO: log error
            print("No response from server")
            error = .response("None")
            return false
        }
        //TODO: check status code
        return true
    }
}
