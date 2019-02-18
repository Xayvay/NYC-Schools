//
//  SchoolInfoViewController.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/17/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import UIKit

class SchoolInfoViewController: UIViewController {


    @IBOutlet weak var testTakerLabel: UILabel!
    @IBOutlet weak var readingScoreLabel: UILabel!
    @IBOutlet weak var writingScoreLabel: UILabel!
    @IBOutlet weak var mathScoreLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet var tableView: UIView!
    @IBOutlet weak var websiteButtonLabel: UIButton!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBAction func websiteButton(_ sender: Any) {
//added the fuctionality to vierw the websites but not every website seems to open the page
        if let url = URL(string: schoolInfo["website"]!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    var schoolInfo = [String:String]()
    var satScores = [String:[String:String]]()
    var googleMapsAPIKey = "AIzaSyBlKrMI1gKvgchYdM7cpOq4svGEUW8TDng"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateData()
        
        websiteButtonLabel.setTitle(schoolInfo["website"]!, for: .normal)
        
        if let email = schoolInfo["email"]{
            emailLabel.text = "Email: \(email)"
        }
        
        if let phone = schoolInfo["phone"]{
            phoneNumberLabel.text = "Phone: \(phone)"
        }

        
    }
    
    func populateData(){
        let satService = SATService()
        satService.getSAT { (sat) in
            if let sat = sat{
                //dispatchqueue so that its on the main queue
                DispatchQueue.main.async{
                    // setting the values for the avg scores
                    if(sat.dbn == self.schoolInfo["dbn"]){
                    self.schoolNameLabel.text = sat.school

                    if let testTakers = sat.testTakers{
                        self.testTakerLabel.text = "# of test takers: \(testTakers)"
                    }else{
                        self.testTakerLabel.text = "N/A"
                    }
                    
                    if let reading = sat.reading{
                        self.readingScoreLabel.text = "Reading: \(reading)"

                    }else{
                        self.readingScoreLabel.text = "N/A"
                    }
                    
                    if let writing = sat.writing{
                        self.writingScoreLabel.text = "Writing: \(writing)"
                    }else{
                        self.writingScoreLabel.text = "N/A"
                    }
                    
                    if let math = sat.math{
                        self.mathScoreLabel.text = "Math: \(math)"
                    }else{
                        self.mathScoreLabel.text = "N/A"
                    }
                    }
                    
                }
        }
    }
    }
}
