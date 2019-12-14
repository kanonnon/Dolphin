//
//  EditOutlineMenuViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/11.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Eureka
import Firebase
import FirebaseDatabase

class EditOutlineMenuViewController: FormViewController {
    
    var selectedOutlineMenu: OutlineMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("概要")
            <<< DateRow("date") {
                $0.title = "日付"
            }
            <<< TimeInlineRow("startTime") {
                $0.title = "開始時刻"
            }
            <<< TimeInlineRow("endTime") {
                $0.title = "終了時刻"
            }
            <<< TextRow("place") {
                $0.title = "場所"
                $0.placeholder = "プールの名前を入力"
                $0.value = selectedOutlineMenu.place
            }
            <<< SegmentedRow<String>("poolType") {
                $0.options = ["短水路", "長水路"]
                $0.title = "プールの長さ                        "
                $0.value = selectedOutlineMenu.place
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
            }
            <<< TextRow("length") {
                $0.title = "合計距離"
                $0.placeholder = "合計距離を入力"
                $0.value = selectedOutlineMenu.length
        }
        
        form +++ ButtonRow() {
            $0.title = "メニューの追加"
            $0.onCellSelection { cell, row in
                print("tapped")
                self.performSegue(withIdentifier: "toTraining", sender: nil)
            }
        }

    }
    
    
}
