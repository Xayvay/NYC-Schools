//
//  SchoolInfoViewController.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/17/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import UIKit

class SchoolInfoViewController: UIViewController {


    var schoolInfo = [String:String]()
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            schoolNameLabel.text = schoolInfo["school"]
    }
    

}
