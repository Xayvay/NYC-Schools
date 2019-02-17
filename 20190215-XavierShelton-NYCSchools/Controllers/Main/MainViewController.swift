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
    var schoolInfo = [String:[String: String]]();
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
       
        populateData()
      
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return schoolInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.textLabel?.numberOfLines = 0;
        let key = Array(schoolInfo.keys)[indexPath.row]
        var schoolData = schoolInfo[key]
         cell.schoolNameLabel?.text = schoolData!["school"]
        
        return(cell)
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        return "NYC Schools"
    }
 
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        view.tintColor = UIColor.black
        header.textLabel?.font = UIFont(name: "Futura", size: 25)!
        header.textLabel?.textColor = UIColor.white
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0;//Choose your custom row height
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
   

    func populateData(){
        let schoolService = SchoolService()
        schoolService.getSchools { (schools) in
            if let schools = schools{
                //dispatchqueue so that its on the main queue
                DispatchQueue.main.async{
                    self.schoolInfo[schools.dbn!] = ["dbn": schools.dbn,
                                                     "school" : schools.school,
                                                     "address" : schools.address,
                                                     "zip" : schools.zip,
                                                     "state":schools.state,
                                                     "phone" : schools.phone,
                                                     "email" : schools.email,
                                                     "website" : schools.website] as? [String : String]
                    self.tableView.reloadData()

                }
            }
        }
    }
}

