//
//  TrainingViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/11.
//  Copyright © 2019 kanon. All rights reserved.

//ユザーでふぉるつで保存させる部分を配列で保存？みたいな

import UIKit
import FirebaseDatabase
import KafkaRefresh
import SwiftDate

class TrainingViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var menuTablaView: UITableView!
    
    var menu = [AddMenu]()
    
    var menuName: String = ""
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        menuTablaView.dataSource = self
        
        
        
        //カスタムセルの登録
        let customCell = UINib(nibName: "SampleTableViewCell", bundle: Bundle.main)
        menuTablaView.register(customCell, forCellReuseIdentifier: "MenuTableViewCell")
        
        menuTablaView.dataSource = self
        menuTablaView.delegate = self
        menuTablaView.tableFooterView = UIView()
        menuTablaView.rowHeight = UITableView.automaticDimension
        menuTablaView.estimatedRowHeight = 44.0
        
        self.loadRecords()
        
        // 引っ張って更新
        menuTablaView.bindHeadRefreshHandler({
            self.loadRecords()
        }, themeColor: .lightGray, refreshStyle: .native)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! SampleTableViewCell
            
        
        cell.menuLabel.text = menu[indexPath.row].memuName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("cellがタップされました")
    }
    
    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        let ud = UserDefaults.standard
        menuName = ud.object(forKey: "menuName") as! String
        
        
//        ref.child("menu").observeSingleEvent(of: .value) { snapshot in
//
//            if let data = snapshot.value as? [String: [String:String]]{
//                self.menu = [AddMenu]()
//
//                for (_, value) in data {
//                    let menus = AddMenu()
//
//                    menus.memuName = value["menuName"]
//                    menus.style = value["style"]
//                    menus.detail = value["detail"]
//                    menus.memo = value["memo"]
//                    menus.distance = value["distance"]
//                    menus.times = value["tims"]
//                    menus.sets = value["sets"]
//                    menus.totalLength = value["totalLength"]
//                    menus.circle = value["circle"]
//                    menus.setRest = value["setRest"]
//                    menus.time = value["time"]
//
//                    self.menu.append(menus)
//                }
//                self.menuTablaView.reloadData()
//
//                self.menuTablaView.headRefreshControl.endRefreshing()
//            }
//        }
    }
  
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
