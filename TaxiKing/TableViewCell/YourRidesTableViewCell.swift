//
//  YourRidesTableViewCell.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 31/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

class YourRidesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
