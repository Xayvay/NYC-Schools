//
//  ViewController.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/15/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import UIKit

var vSpinner: UIView?

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var schoolNames = [String]()
    var schoolInfo = [String:[String: String]]();
    //Created currentIndex to keep track of current index being pressed in Schools View controller
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Calling PopulateData for any dditional setup after loading the view, typically from a nib.
        self.showSpinner(onView: self.view)
        self.populateData()
        //Dispatch after schedules the execution of a block of code instead of freezing the thread:
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            // Put your code which should be executed with a delay here
            self.removeSpinner()
        })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return schoolInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Setting the label values in the table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.textLabel?.numberOfLines = 0;
        let school = schoolNames[indexPath.row]
        cell.schoolNameLabel?.text = school
        let schoolKey = schoolInfo[school]
        cell.cityStateLabel?.text = schoolKey!["city"]
        let offerRate = schoolKey!["offer"]
        //Getting the substring of the offer rate out put to show the percentage of offers
        let startIndex = offerRate!.index(offerRate!.startIndex, offsetBy: 2)
        let endIndex = offerRate!.index(startIndex, offsetBy: 3)
        cell.offersLabel?.text = "Offer Rate\n"
            + "\(String(offerRate![startIndex..<endIndex]))"
        return(cell)
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        return "Super Schools"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        //Setting section header background color,font, and text color
        let header = view as! UITableViewHeaderFooterView
        view.tintColor = UIColor.black
        header.textLabel?.font = UIFont(name: "Futura", size: 25)!
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Choose your custom row height
        return 140.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Updating the current table item picked through index
        currentIndex = indexPath.row
        self.performSegue(withIdentifier: "SchoolInfoVC", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Creating a segue to the schoolInfoViewcontroller.
        if(segue.identifier == "SchoolInfoVC"){
            let schoolInfoVC = segue.destination as! SchoolInfoViewController
            let selectedSchoolName = schoolNames[currentIndex]
            //storing the selected school object into the next view controller
            schoolInfoVC.schoolInfo = schoolInfo[selectedSchoolName]!
        }
    }
    
// Populating the data for the Dictionary and school name array.
    //TODO: Look for anyway to populate this data and their UI labels at the same time
    func populateData(){
        let schoolService = SchoolService()
        schoolService.getSchools { (schools) in
            if let schools = schools{
                //dispatchqueue so that its on the main queue
                DispatchQueue.main.async{
                    //I would prefer to make the dbn the key for [String[String:String]] but for readability purposes I will make the school name the key.
                    self.schoolInfo[schools.school_name!] = ["dbn": schools.dbn,
                                                        "school" : schools.school_name,
                                                        "address" : schools.primary_address_line_1,
                                                        "zip" : schools.zip,
                                                        "state":schools.state_code,
                                                        "city" : schools.city,
                                                        "phone" : schools.phone_number,
                                                        "email" : schools.school_email,
                                                        "offer" : schools.offer_rate1,
                                                        "website" : schools.website,
                                                        "lat" : schools.latitude,
                                                        "lon" : schools.longitude] as? [String : String]
                    //saving all the key values to an array
                    self.schoolNames = Array(self.schoolInfo.keys)
                    //sorting the key value arrays for better readability
                    self.schoolNames = self.schoolNames.sorted()
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
}

/* The data doesnt seem to automatically be in correct order so I used a spinner extension that I recieved from this website:
 http://brainwashinc.com/2017/07/21/loading-activity-indicator-ios-swift/ actually really cool functionality */
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

