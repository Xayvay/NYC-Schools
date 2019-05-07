//
//  SATService.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/16/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation
import UIKit

class SATService{
   
 
        let jsonURLString = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    
    
    // This method will return the schools and have the completion handled
    func  getSAT(completion: @escaping (SAT?) -> Void)
    {
        guard let url = URL(string: jsonURLString) else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                let sATScore = try JSONDecoder().decode([SAT].self, from: data)
                

                for avgSATScore in sATScore{
                
               let score = SAT(satDictionary: avgSATScore)
                completion(score)
                
            }
            } catch let jsonError{
                print ("Error serializing json:", jsonError)
            }
            }.resume()
    }

}
