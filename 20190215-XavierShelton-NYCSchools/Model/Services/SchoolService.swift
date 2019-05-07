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
  
 
        let jsonURLString = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    
    
    // This method will return the schools and have the completion handled
    func  getSchools(completion: @escaping (School?) -> Void)
    {
        guard let url = URL(string: jsonURLString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                let schools = try JSONDecoder().decode([School].self, from: data)
                
            for schoolEntry in schools{
                
                //let school = School(schoolDictionary: schoolEntry)
                completion(schoolEntry)
                }
            } catch let jsonError{
                print ("Error serializing json:", jsonError)
            }
            }.resume()
    }
}
