//
//  RecordTableViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/25.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Firebase
import KafkaRefresh
import SwiftDate

class RecordTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var recordListTableView: UITableView!
    
    var competitions = [Record]()
    
    var key: String!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        recordListTableView.dataSource = self
        
        //カスタムセルの登録
        let customCell = UINib(nibName: "RecordTableViewCell", bundle: Bundle.main)
        recordListTableView.register(customCell,forCellReuseIdentifier:"RecordTableViewCell")
        
        recordListTableView.dataSource = self
        recordListTableView.delegate = self
        recordListTableView.tableFooterView = UIView()
        recordListTableView.rowHeight = UITableView.automaticDimension
        
        self.loadRecords()
        
        //引っ張って更新
        recordListTableView.bindHeadRefreshHandler({
            self.loadRecords()
        }, themeColor: .lightGray, refreshStyle: .native)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell") as! RecordTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        dateFormatter.locale = Locale(identifier: "ja_JP")
        
        let date = dateFormatter.date(from: competitions[indexPath.row].date!)
        
        if let competition = competitions[indexPath.row].competition {
            cell.competitionLabel.text = competition
        }
        
        cell.nameLabel.text = competitions[indexPath.row].name
        cell.dateLabel.text = date?.toFormat("yyyy年 MM月 dd日")
        cell.lengthLabel.text = competitions[indexPath.row].length
        cell.styleLabel.text = competitions[indexPath.row].style
        cell.timeLabel.text = competitions[indexPath.row].totalTime
        print(competitions[indexPath.row].competition)
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
            let editRecordViewController = segue.destination as! EditRecordViewController
            let selectedIndex = recordListTableView.indexPathForSelectedRow!
            editRecordViewController.selectedRecord = competitions[selectedIndex.row]
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        ref.child("competition").observeSingleEvent(of: .value) { snapshot in
            print(snapshot.value as? [String: [String:String]])
            if let data = snapshot.value as? [String: [String:String]]{
                self.competitions = [Record]()
                
                for (_, value) in data {
                    let record = Record()
                    record.id = self.ref.childByAutoId().key
                    record.name = value[Record.field.name.rawValue]
                    record.style = value[Record.field.style.rawValue]
                    record.length = value[Record.field.length.rawValue]
                    record.totalTime = value[Record.field.totalTime.rawValue]
                    record.date = value[Record.field.date.rawValue]
                    record.competition = value[Record.field.competitoin.rawValue]
                    record.place = value[Record.field.place.rawValue]
                    record.poolType = value[Record.field.poolType.rawValue]
                    record.reactionTime = value[Record.field.reactionTime.rawValue]
                    record.firstTime = value[Record.field.firstTime.rawValue]
                    record.firstRap = value[Record.field.firstRap.rawValue]
                    record.secondTime = value[Record.field.secondTime.rawValue]
                    record.secondRap = value[Record.field.secondRap.rawValue]
                    record.thirdTime = value[Record.field.thirdTime.rawValue]
                    record.thridRap = value[Record.field.thridRap.rawValue]
                    record.fourthTime = value[Record.field.fourthTime.rawValue]
                    record.sense = value[Record.field.sense.rawValue]
                    record.motivation = value[Record.field.motivation.rawValue]
                    record.physicalCondition = value[Record.field.physicalCondition.rawValue]
                    record.memo = value[Record.field.memo.rawValue]
                 
                
                    self.competitions.append(record)
                }
                self.recordListTableView.reloadData()
                self.recordListTableView.headRefreshControl.endRefreshing()
            }
        }
    
    }
}
