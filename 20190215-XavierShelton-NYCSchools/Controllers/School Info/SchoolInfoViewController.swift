//
//  SchoolInfoViewController.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/17/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import UIKit
import MapKit

class SchoolInfoViewController: UIViewController {


    @IBOutlet weak var mapView: MKMapView!
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
    var googleMapsAPIKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSpinner(onView: self.view)

        populateData()
        
        schoolMapSearch()
        
        websiteButtonLabel.setTitle(schoolInfo["website"]!, for: .normal)
        
        if let email = schoolInfo["email"]{
            emailLabel.text = "Email: \(email)"
        }
        
        if let phone = schoolInfo["phone"]{
            phoneNumberLabel.text = "Phone: \(phone)"
        }
        
        //Dispatch after schedules the execution of a block of code instead of freezing the thread:
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            // Put your code which should be executed with a delay here
            self.removeSpinner()
        })

        
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
    
    func schoolMapSearch(){

                let latitude = Double(schoolInfo["lat"]!)
                let longitude = Double(schoolInfo["lon"]!)
                //Creating personal annotations
                let annotation = MKPointAnnotation()
                var fullAddress = ""
        if let address = self.schoolInfo["address"]{
            fullAddress = address
        }
        if let state  = self.schoolInfo["state"]{
            fullAddress = fullAddress + ", " + state
        }
        if let zip = self.schoolInfo["zip"]{
            fullAddress = fullAddress + " " + zip
        }
        annotation.coordinate = CLLocationCoordinate2DMake(latitude!,longitude!)
        annotation.title = fullAddress
                self.mapView.addAnnotation(annotation)
                //Zoom into annotation location
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!,longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
   
    }
}
