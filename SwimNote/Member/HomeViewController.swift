//
//  HomeViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/15.
//  Copyright © 2019 kanon. All rights reserved.

//グループに入ってるメンバーの一覧。セルをタップするとその人のマイページが見れるようにする。


import UIKit
import SideMenu

class HomeViewController: UIViewController,UITableViewDataSource,UITabBarDelegate{
    
    var friendName = ["あー","あーあー","あーあーあー"]
    
    @IBOutlet var homeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.dataSource = self
        homeTableView.delegate = self as! UITableViewDelegate
        homeTableView.tableFooterView = UIView()
        let nib = UINib(nibName: "friendPageTableViewCell" , bundle: Bundle.main)
        homeTableView.register(nib, forCellReuseIdentifier: "friendCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as! FriendPageTableViewCell
        cell.friendNameLabel.text = friendName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFriendPage", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
