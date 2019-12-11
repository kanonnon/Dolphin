//
//  RecordViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/11.
//  Copyright © 2019 kanon. All rights reserved.

//詳細タイムの入力するところを泳いだ距離に応じて変えたい。ラップを計算して欲しい。

import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseDatabase

class RecordViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var ref: DatabaseReference!
    
    var selectedImg = UIImage()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
   
        form +++ Section("概要")
            <<< PickerInlineRow<String>("style") { row in
                row.title = "種目"
                row.options = ["Fr","Ba","Br","Fly","IM"]
                row.value = row.options.first
                }.onChange {[unowned self] row in}
            <<< PickerInlineRow<String>("length") { row in
                row.title = "距離"
                row.options = ["25m","50m","100m","200m","400m","800m","1500m"]
                row.value = "100m"
                }.onChange {[unowned self] row in}
            <<< TextRow("totalTime") {
                $0.title = "タイム"
                $0.placeholder = "タイムを入力"
            }
            <<< DateRow("date") {
                $0.title = "日付"
            }
            <<< TextRow("competition") {
                $0.title = "大会名"
                $0.placeholder = "大会名を入力"
            }
            <<< TextRow("place") {
                $0.title = "場所"
                $0.placeholder = "場所を入力"
            }
            <<< SegmentedRow<String>("poolType"){
                $0.options = ["短水路", "長水路"]
                $0.title = "プールの長さ                       "
                $0.value = "短水路"
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
            }
        form +++ Section("タイム詳細")
            <<< TextRow("firstTime") {
                $0.title = "50m"
                $0.placeholder = "50mのタイムを入力"
                }
            <<< TextRow("secondTime") {
                $0.title = "100m"
                $0.placeholder = "100mのタイムを入力"
                }
            <<< TextRow("thirdTime") {
                $0.title = "150m"
                $0.placeholder = "150mのタイムを入力"
                }
            <<< TextRow("fourthTime") {
                $0.title = "200m"
                $0.placeholder = "200mのタイムを入力"
                }
        
        
        form +++ Section("コンディション")
            <<< SegmentedRow<String>("sense"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "水感覚                                "
                $0.value = "普通"
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
                }
            <<< SegmentedRow<String>("motivation"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "モチベーション                  "
                $0.value = "普通"
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
                }
            <<< SegmentedRow<String>("physicalCondition"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "体調                                    "
                $0.value = "普通"
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
                }
        
        form +++ Section("ライバルのタイム")
            <<< TextRow("firstRival") {
                $0.title = "名前"
                $0.placeholder = "ライバルの名前を入力"
        }
            <<< TextRow("firstRivalTime") {
                $0.title = "タイム"
                $0.placeholder = "ライバルのタイムを入力"
        }
            <<< TextRow("secondRival") {
                $0.title = "名前"
                $0.placeholder = "ライバルの名前を入力"
            }
            <<< TextRow("secondRivalTime") {
                $0.title = "タイム"
                $0.placeholder = "ライバルのタイムを入力"
        }

    }
    
    func saveRecord() {
        let formValues = self.form.values()
        let style = formValues["style"] as! String
        let length = formValues["length"] as! String
        let totalTime = formValues["totalTime"] as! String
        let competition = formValues["competition"] as? String
        let date = formValues["date"] as! Date
        let place = formValues["place"] as? String
        let poolType = formValues["poolType"] as! String
        let firstTime = formValues["firstTime"] as? String
        let secondTime = formValues["secondTime"] as? String
        let thirdTime = formValues["thirdTime"] as? String
        let fourthTime = formValues["fourthTime"] as? String
        let sense = formValues["sense"] as! String
        let motivation = formValues["motivation"] as! String
        let physicalCondition = formValues["physicalCondition"] as! String
        let firstRival = formValues["firstRivalTime"] as? String
        let firstRivalTime = formValues["firstRivalTime"] as? String
        let secondRival = formValues["secondRival"] as? String
        let secondRivalTime = formValues["secondRivalTime"] as? String
        
        
        let menu = ["style": style,
                    "length": length,
                    "totalTime": totalTime,
                    "competition": competition,
                    "date": date.description,
                    "place": place,
                    "poolType": poolType,
                    "firstTime": firstTime,
                    "secondTime": secondTime,
                    "thirdTime": thirdTime,
                    "fourthTime": fourthTime,
                    "sense": sense,
                    "motivation": motivation,
                    "physicalCondition": physicalCondition,
                    "firstRival": firstRival,
                    "firstRivalTime": firstRivalTime,
                    "secondRival": secondRival,
                    "secondRivalTime": secondRivalTime] as [String : Any]
            
        self.ref.child("competition").childByAutoId().setValue(menu)
    }
    
    
    @IBAction func save(){
        saveRecord()
        
        let alertController = UIAlertController(title: "保存完了！", message:"メニューの保存が完了しました。大会記録リストに戻ります。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
   

}
