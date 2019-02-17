//
//  ViewController.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/15/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var schoolNames = [String]()
    var schoolInfo = [String:[String: String]]();
    //Created currentIndex to keep track of current index being pressed in Schools View controller
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        // Calling PopulateData for any dditional setup after loading the view, typically from a nib.
        populateData()
        
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
    
    func populateData(){
        let schoolService = SchoolService()
        schoolService.getSchools { (schools) in
            if let schools = schools{
                //dispatchqueue so that its on the main queue
                DispatchQueue.main.async{
                    //I would prefer to make the dbn the key for [String[String:String]] but for readability purposes I will make the school name the key.
                    self.schoolInfo[schools.school!] = ["dbn": schools.dbn,
                                                        "school" : schools.school,
                                                        "address" : schools.address,
                                                        "zip" : schools.zip,
                                                        "state":schools.state,
                                                        "city" : schools.city,
                                                        "phone" : schools.phone,
                                                        "email" : schools.email,
                                                        "offer" : schools.offerRate,
                                                        "website" : schools.website] as? [String : String]
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

