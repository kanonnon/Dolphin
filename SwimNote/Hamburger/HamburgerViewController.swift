//
//  HamburgerViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/11/09.
//  Copyright © 2019 kanon. All rights reserved.

//ハンバーガーメニューの画面
//SideMenuの横幅は大体240くらい

import UIKit
import SideMenu

class HamburgerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var groupNameTablaView: UITableView!
    
    var groupName = ["個人グループ","〇〇高校水泳部","××スイミングクラブ"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupNameTablaView.dataSource = self
        
        groupNameTablaView.delegate = self
        
        let customCell = UINib(nibName: "HamburgerTableViewCell", bundle: Bundle.main)
        groupNameTablaView.register(customCell, forCellReuseIdentifier: "HamburgerTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupName.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerTableViewCell") as! HamburgerTableViewCell
        cell.groupNameLabel.text = groupName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
