//
//  EditRecordNavigationBar.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/09.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class EditRecordNavigationBar: UINavigationBar {
    
    let EditRecordNavigationBar = UIView()
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var barSize = super.sizeThatFits(size)
        barSize.height = 51 // new height
        return barSize;
    }

}
