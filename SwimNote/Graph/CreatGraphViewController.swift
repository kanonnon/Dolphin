//
//  CreatGraphViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/14.
//  Copyright © 2019 kanon. All rights reserved.

//TODO複数選択した後にデータを渡す

import UIKit
import Firebase
import SwiftDate

class CreatGraphViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var createGraphTableView: UITableView!
    
    var competitions = [Record]()
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        // 複数選択を有効にする
        createGraphTableView.allowsMultipleSelectionDuringEditing = true

        ref = Database.database().reference()
        
        
        //カスタムセルの登録
        let customCell = UINib(nibName: "CreatGraphTableViewCell", bundle: Bundle.main)
        createGraphTableView.register(customCell,forCellReuseIdentifier:"CreatGraphTableViewCell")
        
        createGraphTableView.dataSource = self
        createGraphTableView.delegate = self
        createGraphTableView.tableFooterView = UIView()
        createGraphTableView.rowHeight = UITableView.automaticDimension
        
        self.loadRecords()
        
        //引っ張って更新
        createGraphTableView.bindHeadRefreshHandler({
            self.loadRecords()
        }, themeColor: .lightGray, refreshStyle: .native)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        createGraphTableView.isEditing = editing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatGraphTableViewCell") as! CreatGraphTableViewCell
        
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
    
    
    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        ref.child("competition").observeSingleEvent(of: .value) { snapshot in
            
            if let data = snapshot.value as? [String: [String:String]]{
                self.competitions = [Record]()
                
                for (_, value) in data {
                    let record = Record()
                    record.name = value[Record.field.name.rawValue]
                    record.style = value[Record.field.style.rawValue]
                    record.length = value[Record.field.length.rawValue]
                    record.totalTime = value[Record.field.totalTime.rawValue]
                    record.date = value[Record.field.date.rawValue]
                    record.competition = value[Record.field.competitoin.rawValue]
                    record.place = value[Record.field.place.rawValue]
                    record.poolType = value[Record.field.poolType.rawValue]
                    record.firstTime = value[Record.field.firstTime.rawValue]
                    record.secondTime = value[Record.field.secondTime.rawValue]
                    record.thirdTime = value[Record.field.thirdTime.rawValue]
                    record.fourthTime = value[Record.field.fourthTime.rawValue]
                    record.sense = value[Record.field.sense.rawValue]
                    record.motivation = value[Record.field.motivation.rawValue]
                    record.physicalCondition = value[Record.field.physicalCondition.rawValue]
                    
                    
                    self.competitions.append(record)
                }
                self.createGraphTableView.reloadData()
                self.createGraphTableView.headRefreshControl.endRefreshing()
            }
        }
        
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select - \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselect - \(indexPath)")
    }
}
