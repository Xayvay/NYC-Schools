//
//  MainTableViewCell.swift
//  20190215-XavierShelton-NYCSchools
//
//  Created by Xavier Shelton on 2/16/19.
//  Copyright © 2019 Xavier Shelton. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var almightImage: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
