//
//  Schools.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/16/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

class School
{
    let school: String?
    let dbn: String?
    let zip: String?
    let address: String?
    let state: String?
    let phone: String?
    let email: String?
    let website: String?
    let offerRate: String?
    let city: String?
    
    struct schoolKeys {
        static let school = "school_name"
        static let dbn = "dbn"
        static let zip = "zip"
        static let address = "primary_address_line_1"
        static let state = "state_code"
        static let phone = "phone_number"
        static let website = "website"
        static let email = "school_email"
        static let offerRate = "offer_rate1"
        static let city = "city"
    }
    
    init(schoolDictionary: [String:Any])
    {
        school = schoolDictionary[schoolKeys.school] as? String
        dbn = schoolDictionary[schoolKeys.dbn] as? String
        zip = schoolDictionary[schoolKeys.zip] as? String
        address = schoolDictionary[schoolKeys.address] as? String
        state = schoolDictionary[schoolKeys.state] as? String
        phone = schoolDictionary[schoolKeys.phone] as? String
        email = schoolDictionary[schoolKeys.email] as? String
        website = schoolDictionary[schoolKeys.website] as? String
        offerRate = schoolDictionary[schoolKeys.offerRate] as? String
        city = schoolDictionary[schoolKeys.city] as? String
    }
}
