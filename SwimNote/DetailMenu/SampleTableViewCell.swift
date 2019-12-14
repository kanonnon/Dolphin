//
//  SampleTableViewCell.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/18.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    @IBOutlet var timesLabel: UILabel!
    @IBOutlet var setsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
