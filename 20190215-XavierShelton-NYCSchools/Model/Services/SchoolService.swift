//
//  SchoolService.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/16/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

class SchoolService
{
  
    let schoolBaseURL: URL?
    
    init()
    {
        schoolBaseURL = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
    }
    
    // This method will return the schools and have the completion handled
    func  getSchools(completion: @escaping (School?) -> Void)
    {
        let networkProcessor = NetworkProcessor(url:schoolBaseURL!)
        networkProcessor.downloadJSONFromURL ({(jsonDictionary) in
            //Due to having an array of objects in an object from JSON. We have to loop through all the object entries then store them in schoolDictionary
            for schoolEntry in jsonDictionary!{

                    let school = School(schoolDictionary: schoolEntry)
                    completion(school)

            }
        })
    }
}
