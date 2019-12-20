//
//  InputViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/11.
//  Copyright © 2019 kanon. All rights reserved.

//合計距離をAddMenuViewControllerで入力したメニューをもとに自動的に計算して欲しい。

import UIKit
import Eureka
import ImageRow
import FirebaseDatabase

class OutlineMenuViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var selectedImg = UIImage()
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
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
            }
            <<< SegmentedRow<String>("poolType") {
                $0.options = ["短水路", "長水路"]
                $0.title = "プールの長さ                        "
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
            }
            <<< TextRow("length") {
                $0.title = "合計距離"
                $0.placeholder = "m"
        }
        
        form +++ ButtonRow() {
            $0.title = "メニューの追加"
            $0.onCellSelection { cell, row in
                print("tapped")
                self.performSegue(withIdentifier: "toTraining", sender: nil)
            }
        }
        
    }
    
    func saveMenu() {
        //TODO: - 頑張る
        let ud = UserDefaults.standard
        let formValues = self.form.values()
        let date = formValues["date"] as! Date
        let startTime = formValues["startTime"] as! Date
        let endTime = formValues["endTime"] as! Date
        let place = formValues["place"] as? String
        let poolType = formValues["poolType"] as! String
        let length = formValues["length"] as? String
        
        if let menus = ud.array(forKey: "menus") as? [Dictionary<String, String?>] {
            let menu = ["date":  date.description,
                        "startTime": startTime.description,
                        "endTime": endTime.description,
                        "place": place,
                        "poolType": poolType,
                        "length": length,
                        "menus": menus,
                        "imageUrl": "https://www.google.com"] as [String : Any]
            self.ref.child("menu").childByAutoId().setValue(menu)
            
            // TODO: - データベースへの保存が終わったら、一時保存しているメニューの削除
            ud.removeObject(forKey: "menus")
            ud.synchronize()
        } else {
            print("メニューないよ")
        }
        
        
    }
    
    @IBAction func save(){
        saveMenu()
        
        let alertController = UIAlertController(title: "保存完了！", message:"メニューの保存が完了しました。練習記録リストに戻ります。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

