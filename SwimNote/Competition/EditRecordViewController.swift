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
    
//    var selectedKey: String!
    
    var selectedImg = UIImage()
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = Database.database().reference()
        
        form +++ Section("")
            <<< ButtonRow("この内容に変更") { (row: ButtonRow) in
                row.title = row.tag
                }
                .onCellSelection({ (cell, row) in
                    //更新するコードを書く
                   self.updateRecord()
                    let alertController = UIAlertController(title: "変更完了！", message:"入力された内容に変更しました。", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                })
        form +++ Section("概要")
            <<< TextRow("name") {
                $0.title = "選手氏名"
                $0.placeholder = "選手の名前を入力"
                $0.value = selectedRecord.name
            }
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
            <<< TextRow("reactionTime") {
                $0.title = "ﾘｱｸｼｮﾝﾀｲﾑ"
                $0.placeholder = "ﾘｱｸｼｮﾝﾀｲﾑを入力"
                $0.value = selectedRecord.reactionTime
            }
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
            <<< TextRow("firstRap") {
                $0.title = " "
                $0.placeholder = "ラップを入力"
                $0.value = selectedRecord.firstRap
            }
            
            <<< TextRow("thirdTime") {
                $0.title = "150m"
                $0.placeholder = "150mのタイムを入力"
                $0.value = selectedRecord.thirdTime
            }
            <<< TextRow("secondRap") {
                $0.title = " "
                $0.placeholder = "ラップを入力"
                $0.value = selectedRecord.secondRap
            }
            
            <<< TextRow("fourthTime") {
                $0.title = "200m"
                $0.placeholder = "200mのタイムを入力"
                $0.value = selectedRecord.fourthTime
        }
            <<< TextRow("thridRap") {
                $0.title = " "
                $0.placeholder = "ラップを入力"
                $0.value = selectedRecord.thridRap
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
            form +++ Section("メモ")
            <<< TextAreaRow("memo") { row in
                row.title = "メモ"
                row.value = selectedRecord.memo
        }
        
    }

    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func updateRecord() {
        let formValues = self.form.values()
        let name = formValues["name"] as! String
        let style = formValues["style"] as! String
        let length = formValues["length"] as! String
        let totalTime = formValues["totalTime"] as! String
        let competition = formValues["competition"] as? String
        let date = formValues["date"] as! Date
        let place = formValues["place"] as? String
        let poolType = formValues["poolType"] as! String
        let reactionTime = formValues["reactionTime"] as? String
        let firstTime = formValues["firstTime"] as? String
        let firstRap = formValues["firstRap"] as? String
        let secondTime = formValues["secondTime"] as? String
        let secondRap = formValues["secondRap"] as? String
        let thirdTime = formValues["thirdTime"] as? String
        let thridRap = formValues["thridRap"] as? String
        let fourthTime = formValues["fourthTime"] as? String
        let sense = formValues["sense"] as? String
        let motivation = formValues["motivation"] as? String
        let physicalCondition = formValues["physicalCondition"] as? String
        let memo = formValues["memo"] as? String
        
        
        let menu = ["name": name,
                    "style": style,
                    "length": length,
                    "totalTime": totalTime,
                    "competition": competition,
                    "date": date.description,
                    "place": place,
                    "poolType": poolType,
                    "reactionTime": reactionTime,
                    "firstTime": firstTime,
                     "firstRap": firstRap,
                    "secondTime": secondTime,
                    "secondRap": secondRap,
                    "thirdTime": thirdTime,
                    "thridRap": thridRap,
                    "fourthTime": fourthTime,
                    "sense": sense,
                    "motivation": motivation,
                    "physicalCondition": physicalCondition,
                    "memo": memo] as [String : Any]
        ref.child("competition/-Lw3tk-fX7iRnyiEbywq").updateChildValues(menu)
    }
    
    func removeRecord() {
        let formValues = self.form.values()
        let name = formValues["name"] as! String
        let style = formValues["style"] as? String
        let length = formValues["length"] as? String
        let totalTime = formValues["totalTime"] as? String
        let competition = formValues["competition"] as? String
        let date = formValues["date"] as? Date
        let place = formValues["place"] as? String
        let poolType = formValues["poolType"] as? String
        let reactionTime = formValues["reactionTime"] as? String
        let firstTime = formValues["firstTime"] as? String
        let firstRap = formValues["firstRap"] as? String
        let secondTime = formValues["secondTime"] as? String
        let secondRap = formValues["secondRap"] as? String
        let thirdTime = formValues["thirdTime"] as? String
        let thridRap = formValues["thridRap"] as? String
        let fourthTime = formValues["fourthTime"] as? String
        let sense = formValues["sense"] as? String
        let motivation = formValues["motivation"] as? String
        let physicalCondition = formValues["physicalCondition"] as? String
        let memo = formValues["memo"] as? String
        
        let menu = ["name": name,
                    "style": style,
                    "length": length,
                    "totalTime": totalTime,
                    "competition": competition,
                    "date": date?.description,
                    "place": place,
                    "poolType": poolType,
                    "reactionTime": reactionTime,
                    "firstTime": firstTime,
                    "firstRap": firstRap,
                    "secondTime": secondTime,
                    "secondRap": secondRap,
                    "thirdTime": thirdTime,
                    "thridRap": thridRap,
                    "fourthTime": fourthTime,
                    "sense": sense,
                    "motivation": motivation,
                    "physicalCondition": physicalCondition,
                    "memo": memo] as [String : Any]
        
        self.ref.child("competition/\(selectedRecord.id)").childByAutoId().removeValue()
    }
 
    
    
    @IBAction func remove(){
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "保存してもいいですか？", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.removeRecord()
            self.navigationController?.popViewController(animated: true)
            print("OK")
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
 
    
    }
