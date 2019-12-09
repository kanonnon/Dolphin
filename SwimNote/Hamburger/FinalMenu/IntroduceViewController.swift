//
//  IntroduceViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/09.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class IntroduceViewController: UIViewController {
    
    var  selectedName: String = ""
    
    @IBOutlet var selectedNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedNameLabel.text = selectedName

    }
    


}
