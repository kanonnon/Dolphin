//
//  EditRecordViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/08.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Eureka
import ImageRow

class EditRecordViewController: FormViewController {
    
    var selectedRecord: Record!
    
    var selectedImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("")
            <<< ButtonRow("この内容に変更") { (row: ButtonRow) in
                row.title = row.tag
                }
                .onCellSelection({ (cell, row) in
                    self.dismiss(animated: true, completion: nil)
                })
        form +++ Section("概要")
            <<< PickerInlineRow<String>("style") { row in
                row.title = "種目"
                row.options = ["Fr","Ba","Br","Fly","IM"]
                row.value = selectedRecord.style
                }.onChange {[unowned self] row in}
            <<< PickerInlineRow<String>("length") { row in
                row.title = "距離"
                row.options = ["25m","50m","100m","200m","400m","800m","1500m"]
                row.value = selectedRecord.length
                }.onChange {[unowned self] row in}
            <<< TextRow("totalTime") {
                $0.title = "タイム"
                $0.placeholder = "タイムを入力"
                $0.value = selectedRecord.totalTime
            }
            <<< DateRow("date") {
                $0.title = "日付"
            }
            <<< TextRow("competition") {
                $0.title = "大会名"
                $0.placeholder = "大会名を入力"
                $0.value = selectedRecord.competition
            }
            <<< TextRow("place") {
                $0.title = "場所"
                $0.value = selectedRecord.place
            }
            <<< SegmentedRow<String>("poolType"){
                $0.options = ["短水路", "長水路"]
                $0.title = "プールの長さ                       "
                $0.value = selectedRecord.poolType
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
        }
        form +++ Section("タイム詳細")
            <<< TextRow("firstTime") {
                $0.title = "50m"
                $0.placeholder = "50mのタイムを入力"
                $0.value = selectedRecord.firstTime
            }
            <<< TextRow("secondTime") {
                $0.title = "100m"
                $0.placeholder = "100mのタイムを入力"
                $0.value = selectedRecord.secondTime
            }
            <<< TextRow("thirdTime") {
                $0.title = "150m"
                $0.placeholder = "150mのタイムを入力"
                $0.value = selectedRecord.thirdTime
            }
            <<< TextRow("fourthTime") {
                $0.title = "200m"
                $0.placeholder = "200mのタイムを入力"
                $0.value = selectedRecord.fourthTime
        }
        
        
        form +++ Section("コンディション")
            <<< SegmentedRow<String>("sense"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "水感覚                                "
                $0.value = selectedRecord.sense
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
            }
            <<< SegmentedRow<String>("motivation"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "モチベーション                  "
                $0.value = selectedRecord.motivation
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
            }
            <<< SegmentedRow<String>("physicalCondition"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "体調                                    "
                $0.value = selectedRecord.physicalCondition
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
        }
        
        form +++ Section("ライバルのタイム")
            <<< TextRow("firstRival") {
                $0.title = "名前"
                $0.placeholder = "ライバルの名前を入力"
                $0.value = selectedRecord.firstRival
            }
            <<< TextRow("firstRivalTime") {
                $0.title = "タイム"
                $0.placeholder = "ライバルのタイムを入力"
                $0.value = selectedRecord.firstRivalTime
            }
            <<< TextRow("secondRival") {
                $0.title = "名前"
                $0.placeholder = "ライバルの名前を入力"
                $0.value = selectedRecord.secondRival
            }
            <<< TextRow("secondRivalTime") {
                $0.title = "タイム"
                $0.placeholder = "ライバルのタイムを入力"
                $0.value = selectedRecord.secondRivalTime
        }
        
    }

    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
}
