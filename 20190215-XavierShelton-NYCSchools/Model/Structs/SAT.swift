//
//  SAT.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 5/6/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

class SAT:Decodable{
    let school_name: String?
    let dbn: String?
    let sat_critical_reading_avg_score: String?
    let sat_math_avg_score: String?
    let sat_writing_avg_score: String?
    let num_of_sat_test_takers: String?
}
