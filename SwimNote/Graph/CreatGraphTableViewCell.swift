//
//  CreatGraphTableViewCell.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/14.
//  Copyright © 2019 kanon. All rights reserved.

//TODOUI綺麗に

import UIKit

class CreatGraphTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var competitionLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
