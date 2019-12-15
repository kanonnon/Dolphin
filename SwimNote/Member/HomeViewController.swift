//
//  HomeViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/15.
//  Copyright © 2019 kanon. All rights reserved.

//グループに入ってるメンバーの一覧。セルをタップするとその人のマイページが見れるようにする。
//TODOグループ作れたら取り掛かる


import UIKit
import SideMenu

class HomeViewController: UIViewController{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFriendPage", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    
}
