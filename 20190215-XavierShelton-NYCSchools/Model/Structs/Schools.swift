//
//  Schools.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/16/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import Foundation

struct School:Decodable
{
    let school_name: String?
    let dbn: String?
    let zip: String?
    let primary_address_line_1: String?
    let state_code: String?
    let phone_number: String?
    let school_email: String?
    let website: String?
    let offer_rate1: String?
    let city: String?
    let latitude: String?
    let longitude: String?
}
