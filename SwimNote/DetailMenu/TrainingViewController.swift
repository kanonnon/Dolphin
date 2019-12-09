//
//  TrainingViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/11.
//  Copyright © 2019 kanon. All rights reserved.


import UIKit
import FirebaseDatabase
import KafkaRefresh
import SwiftDate

class TrainingViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var menuTablaView: UITableView!
    
    var menus = [Dictionary<String, String?>]()
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //編集
        menuTablaView.isEditing = true
        menuTablaView.allowsSelectionDuringEditing = true
        
        ref = Database.database().reference()
        
        menuTablaView.dataSource = self
        menuTablaView.delegate = self
        
        
        //カスタムセルの登録
        let customCell = UINib(nibName: "SampleTableViewCell", bundle: Bundle.main)
        menuTablaView.register(customCell, forCellReuseIdentifier: "MenuTableViewCell")
        
        menuTablaView.dataSource = self
        menuTablaView.delegate = self
        menuTablaView.tableFooterView = UIView()
        menuTablaView.rowHeight = UITableView.automaticDimension
        menuTablaView.estimatedRowHeight = 44.0

        self.loadRecords()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuTablaView.bindHeadRefreshHandler({
            self.loadRecords()
            self.menuTablaView.reloadData()
        }, themeColor: .lightGray, refreshStyle: .native)
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! SampleTableViewCell
        
        cell.menuLabel.text = menus[indexPath.row]["menuName"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("cellがタップされました")
    }
    
    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        let ud = UserDefaults.standard
        
        if let menus = ud.array(forKey: "menus") as? [Dictionary<String, String?>] {
            self.menus = menus
            //self.menuTablaView.headRefreshControl.endRefreshing()
        } else {
            print("メニューなし")
        }
        // menuName = ud.object(forKey: "menuName") as? String ?? ""
//        style = ud.object(forKey: "style") as? String ?? ""
//        detail = ud.object(forKey: "detail") as? String ?? ""
//        memo = ud.object(forKey: "memo") as? String ?? ""
//        distance = ud.object(forKey: "distance") as? String ?? ""
//        times = ud.object(forKey: "times") as? String ?? ""
//        sets = ud.object(forKey: "sets") as? String ?? ""
//        totalLength = ud.object(forKey: "totalLength") as? String ?? ""
//        circle = ud.object(forKey: "circle") as? String ?? ""
//        setRest = ud.object(forKey: "setRest") as? String ?? ""
//        time = ud.object(forKey: "time") as? String ?? ""
        
        // menu.append(AddMenu(menuName: menuName, style: menuName, detail: menuName, memo: menuName, distance: menuName, times: menuName, sets: menuName, totalLength: menuName, circle: menuName, setRest: menuName, time: menuName))
//        menu = ud.object(forKey: "menu") as! [AddMenu]
        // print(menu.count)
        
    }
    //編集
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // TODO: 入れ替え時の処理を実装する（データ制御など）
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
  
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
