//
//  FriendPageTableViewCell.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/15.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class FriendPageTableViewCell: UITableViewCell {
    
    @IBOutlet var friendIconImage: UIImage!
    @IBOutlet var friendNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
