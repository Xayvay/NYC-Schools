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
    
}
