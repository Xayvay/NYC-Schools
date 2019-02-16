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
    var schoolNameArray = [String]();
    var zipArray = [String]();
    var dbnArray = [String]();
    var addressArray = [String]()
    var stateArray = [String]()
    let list = ["milk","honey","bread"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        populateData()
      
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return schoolNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.schoolNameLabel.text = self.schoolNameArray[indexPath.row]
        
        return(cell)
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
                    self.schoolNameArray.append(schools.school!);
                    self.zipArray.append(schools.zip!);
                    self.dbnArray.append(schools.dbn!);
                    self.tableView.reloadData()

                }
            }
        }
    }
}

