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
    
    
    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        let ud = UserDefaults.standard
        
        if let menus = ud.array(forKey: "menus") as? [Dictionary<String, String?>] {
            self.menus = menus
            //self.menuTablaView.headRefreshControl.endRefreshing()
        } else {
            print("メニューなし")
        }
        
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
    
    //セルがタップされた時にどのセルがタップされたかを知る、ずっと選択状態になっているのを解除する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toEdit", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //編集の画面に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit"{
            let editDitailMenuViewController = segue.destination as! EditDitailMenuViewController
            let selectedIndex = menuTablaView.indexPathForSelectedRow
            editDitailMenuViewController.selectedDitailMenu = menus[(selectedIndex?.row)!]
        }
    }
        
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
