//
//  PracticeRecordListTableViewCell.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/25.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class OutlineMenuListTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var startTimeLabel:UILabel!
    @IBOutlet var endTimeLabel:UILabel!
    @IBOutlet var placeLabel:UILabel!
    @IBOutlet var poolTypeLabel:UILabel!
    @IBOutlet var lengthLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
