//
//  SATService.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/16/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

class SATService{
   
    let satBaseUrl: URL?
    
    init()
    {
        satBaseUrl = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
    }
    
    // This method will return the schools and have the completion handled
    func  getSAT(completion: @escaping (SAT?) -> Void)
    {
        let networkProcessor = NetworkProcessor(url:satBaseUrl!)
        networkProcessor.downloadJSONFromURL ({(jsonDictionary) in
            //Due to having an array of objects in an object from JSON. We have to loop through all the object entries then store them in schoolDictionary
            for avgSATScore in jsonDictionary!{
                
                let score = SAT(satDictionary: avgSATScore)
                completion(score)
                
            }
        })
    }
}
