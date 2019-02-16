//
//  NetworkProcessor.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/15/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

// Created a network processing class for consuming the apis. When you run into any issues with api consumption please look here.

class NetworkProcessor
{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    let url: URL
    
    init(url: URL)
    {
        self.url = url
    }
 
    /* Created a closure with a return void to handle the recieved JSON and wrapping it in a typealias to make it easier for readability
     * Note: utilized Double square brackets based off of how the Json is recieved from the API endpoint.This represents an array of arrays that contains objects of String:Any */
    
    typealias JSONDictionaryHandler = (([[String: Any]]?) -> Void)

    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler)
    {
        //request to download the data
        let request = URLRequest(url:self.url)
        // data task for downloading data
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil{
                
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode{
                    case 200:
                        // The response is successful
                        
                        if let data = data {
                            do{
                            let jsonDictionary = try JSONSerialization.jsonObject(with:data,options:.mutableContainers)
                           // pass dictionary back into completion handler
                        
                                completion(jsonDictionary as? [[String:Any]])
                                
                            } catch let error as NSError{
                                print("Error processing json data: \(error.localizedDescription)")
                            }
                        
                        }
                        break
                    default:
                        print("HTTP Response: \(httpResponse.statusCode)")
                    }
            
                }
                
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        // resumes the dataTask for any suspensions
        dataTask.resume()
    }
    
}
