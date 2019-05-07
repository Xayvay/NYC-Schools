//
//  SAT.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 5/6/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

class SAT:Decodable{
    let school: String?
    let dbn: String?
    let reading: String?
    let math: String?
    let writing: String?
    let testTakers: String?
    
    struct satKeys {
        static let school = "school_name"
        static let dbn = "dbn"
        static let testTakers = "num_of_sat_test_takers"
        static let reading = "sat_critical_reading_avg_score"
        static let math = "sat_math_avg_score"
        static let writing = "sat_writing_avg_score"
    }
    
    init(satDictionary: SAT)
    {
        school = satDictionary.school
        dbn = satDictionary.dbn
        testTakers = satDictionary.testTakers
        reading = satDictionary.reading
        math = satDictionary.math
        writing = satDictionary.writing
    }
}
