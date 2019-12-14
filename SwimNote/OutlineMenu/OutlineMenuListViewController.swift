//
//  PracticeRecordListViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/25.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import KafkaRefresh
import SwiftDate

class OutlineMenuListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var OutlineMenuListTableView: UITableView!

    var records = [OutlineMenu]()
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //OutlineMenuListTableView.dataSource = self
        
        //カスタムセルの登録
        let customCell = UINib(nibName: "OutlineMenuListTableViewCell", bundle: Bundle.main)
        OutlineMenuListTableView.register(customCell,forCellReuseIdentifier:"OutlineMenuListTableViewCell")
        
        
        
        OutlineMenuListTableView.dataSource = self
        OutlineMenuListTableView.delegate = self
    
        OutlineMenuListTableView.tableFooterView = UIView()
        OutlineMenuListTableView.rowHeight = UITableView.automaticDimension
        OutlineMenuListTableView.estimatedRowHeight = 44.0
        
        self.loadRecords()
        
        // 引っ張って更新
        OutlineMenuListTableView.bindHeadRefreshHandler({
            self.loadRecords()
        }, themeColor: .lightGray, refreshStyle: .native)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutlineMenuListTableViewCell") as! OutlineMenuListTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        dateFormatter.locale = Locale(identifier: "ja_JP")
        
        let date = dateFormatter.date(from: records[indexPath.row].date!)
        let startTime = dateFormatter.date(from: records[indexPath.row].startTime!)
        if let endTimeString = records[indexPath.row].endTime {
            let endTime = dateFormatter.date(from: endTimeString)
            cell.endTimeLabel.text = endTime?.toFormat("HH:mm")
        }
        
        
        cell.dateLabel.text = date?.toFormat("yyyy年 MM月 dd日")
        cell.startTimeLabel.text = startTime?.toFormat("HH:mm")
        
        cell.placeLabel.text = records[indexPath.row].place
        cell.poolTypeLabel.text = records[indexPath.row].poolType
        cell.lengthLabel.text = records[indexPath.row].length
        return cell
    }
    
    //セルがタップされた時にどのセルがタップされたかを知る、ずっと選択状態になっているのを解除する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toEdit", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //編集の画面に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit"{
            let editOutlineViewController = segue.destination as! EditOutlineMenuViewController
            let selectedIndex = OutlineMenuListTableView.indexPathForSelectedRow!
            editOutlineViewController.selectedOutlineMenu = records[selectedIndex.row]
        }
    }
    
    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        ref.child("menu").observeSingleEvent(of: .value) { snapshot in
            
            if let data = snapshot.value as? [String: [String:String]]{
                self.records = [OutlineMenu]()
                
                for (_, value) in data {
                    let record = OutlineMenu()
                    
                    record.date = value["date"]
                    record.startTime = value["startTime"]
                    record.endTime = value["endTime"]
                    record.place = value["place"]
                    record.poolType = value["poolType"]
                    record.length = value["length"]
                    record.imageUrl = value["imageUrl"]
                    
                    self.records.append(record)
                }
                self.OutlineMenuListTableView.reloadData()
                self.OutlineMenuListTableView.headRefreshControl.endRefreshing()
            }
        }
    }
   
}

