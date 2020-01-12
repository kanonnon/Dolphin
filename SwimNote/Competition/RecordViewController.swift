//
//  RecordViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/11.
//  Copyright © 2019 kanon. All rights reserved.


import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseDatabase

class RecordViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var ref: DatabaseReference!
    
    var selectedImg = UIImage()
    var diff: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
   
        form +++ Section("概要")
            <<< TextRow("name") {
                $0.title = "選手氏名"
                $0.placeholder = "選手の名前を入力"
            }
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
            <<< TextRow("reactionTime") {
                $0.title = "ﾘｱｸｼｮﾝﾀｲﾑ"
                $0.placeholder = "ﾘｱｸｼｮﾝﾀｲﾑを入力"
            }
            <<< TextRow("firstTime") {
                $0.title = "50m"
                $0.placeholder = "50mのタイムを入力"
                }.onChange({ (row) in
                    if let timeValue = row.value?.components(separatedBy: ".") {
                        print(timeValue)
                        if timeValue.count > 2 {
                            print(timeValue[0] + "分" + timeValue[1] + "秒" +  timeValue[2])
                        }
                    }
                    if let firstTimeValue = row.value {
                        if firstTimeValue != nil {
                            self.form.rowBy(tag: "firstRap")?.value = self.calcDiff1()
                                self.form.rowBy(tag: "firstRap")?.reload()
//                            }
                        }
                    }
                })
            
            <<< TextRow("secondTime") {
                $0.title = "100m"
                $0.placeholder = "100mのタイムを入力"
                }.onChange({ (row) in
                    if let timeValue = row.value?.components(separatedBy: ".") {
                        print(timeValue)
                        if timeValue.count > 2 {
                            print(timeValue[0] + "分" + timeValue[1] + "秒" +  timeValue[2])
                        }
                    }
                    if let secondTimeValue = row.value{
                        if secondTimeValue != nil{
                            self.form.rowBy(tag: "firstRap")?.value = self.calcDiff1()
                                self.form.rowBy(tag: "firstRap")?.reload()
                            self.form.rowBy(tag: "secondRap")?.value = self.calcDiff2()
                            self.form.rowBy(tag: "secondRap")?.reload()
                        }
                    }
                })
            
            <<< TextRow("firstRap") {
                $0.title = "ラップ"
                $0.value = ""
                $0.disabled = true
                }.onCellSelection({ (cell, row) in
                    print("tap!!!!!!")
                    
                })
            
            <<< TextRow("thirdTime") {
                $0.title = "150m"
                $0.placeholder = "150mのタイムを入力"
                }.onChange({ (row) in
                    if let timeValue = row.value?.components(separatedBy: ".") {
                        print(timeValue)
                        if timeValue.count > 2 {
                            print(timeValue[0] + "分" + timeValue[1] + "秒" +  timeValue[2])
                        }
                    }
                    if let thirdTimeValue = row.value{
                        if thirdTimeValue != nil{
                            self.form.rowBy(tag: "secondRap")?.value = self.calcDiff2()
                            self.form.rowBy(tag: "secondRap")?.reload()
                            self.form.rowBy(tag: "thridRap")?.value = self.calcDiff3()
                            self.form.rowBy(tag: "thridRap")?.reload()
                        }
                    }
                })
            <<< TextRow("secondRap") {
                $0.title = "ラップ"
                $0.disabled = true
                }.onCellSelection({ (cell, row) in
                    print("tap!!!!!!")
                })
            <<< TextRow("fourthTime") {
                $0.title = "200m"
                $0.placeholder = "200mのタイムを入力"
                }.onChange({ (row) in
                    if let timeValue = row.value?.components(separatedBy: ".") {
                        print(timeValue)
                        if timeValue.count > 2 {
                            print(timeValue[0] + "分" + timeValue[1] + "秒" +  timeValue[2])
                        }
                    }
                    if let forthTimeValue = row.value{
                        if forthTimeValue != nil{
                            self.form.rowBy(tag: "thridRap")?.value = self.calcDiff3()
                            self.form.rowBy(tag: "thridRap")?.reload()
                        }
                    }
                })
            <<< TextRow("thridRap") {
                $0.title = "ラップ"
                $0.disabled = true
                }.onCellSelection({ (cell, row) in
                    print("tap!!!!!!")
                })

        
        
        form +++ Section("コンディション")
            <<< SegmentedRow<String>("sense"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "水感覚                                "
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
                }
            <<< SegmentedRow<String>("motivation"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "モチベーション                  "
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
                }
            <<< SegmentedRow<String>("physicalCondition"){
                $0.options = ["良い", "普通","悪い"]
                $0.title = "体調                                    "
                }.onChange{ row in
                    let userDefault = UserDefaults.standard
                    userDefault.setValue(row.value, forKey: "")
                }
            form +++ Section("メモ")
            <<< TextAreaRow("memo") { row in
                row.title = "メモ"
                }
        
    }
    func calcDiff1() -> String {
        let formValues = self.form.values()
        let secondTime = formValues["secondTime"] as? String
        let firstTime = formValues["firstTime"] as? String
        
        // second - first
        var f_min = 0
        var f_sec = 0
        var f_msec = 0
        if let firstTimeValue = firstTime?.components(separatedBy: ".") {
            if firstTimeValue.count > 2 {
                if let f_min_v = Int(firstTimeValue[0]) {
                    f_min = f_min_v
                }
                if let f_sec_v = Int(firstTimeValue[1]) {
                    f_sec = f_sec_v
                }
                if let f_msec_v = Int(firstTimeValue[2]) {
                    f_msec = f_msec_v
                }
            }
        }
        
        var s_min = 0
        var s_sec = 0
        var s_msec = 0
        if let secondTimeValue = secondTime?.components(separatedBy: ".") {
            if secondTimeValue.count > 2 {
                if let s_min_v = Int(secondTimeValue[0]) {
                    s_min = s_min_v
                }
                if let s_sec_v = Int(secondTimeValue[1]) {
                    s_sec = s_sec_v
                }
                if let s_msec_v = Int(secondTimeValue[2]) {
                    s_msec = s_msec_v
                }
            }
        }
        
        let f_total_msec = (6000*f_min)+(100*f_sec)+(f_msec)
        let s_total_msec = (6000*s_min)+(100*s_sec)+(s_msec)
        
        
        var total_msec = (s_total_msec)-(f_total_msec)
        
        if total_msec > 0{
            func millisecondsToMinutesSecondsMilliseconds (seconds : Int) -> (Int, Int, Int) {
                return (total_msec / 6000, (total_msec % 6000) / 100, (total_msec % 6000) % 100)
            }
        }else{
           total_msec = 0
        }
        
        if (total_msec % 6000) / 100 > 9 && (total_msec % 6000) % 100 > 9{
            let result = "\(total_msec / 6000).\((total_msec % 6000) / 100).\((total_msec % 6000) % 100)"
            return result
        }else if (total_msec % 6000) / 100 > 9 && (total_msec % 6000) % 100 < 10 {
            let result2 = "\(total_msec / 6000).\((total_msec % 6000) / 100).0\((total_msec % 6000) % 100)"
            return result2
        }else if (total_msec % 6000) / 100 < 10 && (total_msec % 6000) % 100 > 9{
            let result3 = "\(total_msec / 6000).0\((total_msec % 6000) / 100).\((total_msec % 6000) % 100)"
            return result3
        }else{
            let result4 = "\(total_msec / 6000).0\((total_msec % 6000) / 100).0\((total_msec % 6000) % 100)"
            return result4
        }
        
        print(total_msec / 6000, (total_msec % 6000) / 100, (total_msec % 6000) % 100)
    }
    
    func calcDiff2() -> String {
        let formValues = self.form.values()
        let secondTime = formValues["secondTime"] as? String
        let thirdTime = formValues["thirdTime"] as? String
        
        // third - second
        var t_min = 0
        var t_sec = 0
        var t_msec = 0
        if let thirdTimeValue = thirdTime?.components(separatedBy: ".") {
            if thirdTimeValue.count > 2 {
                if let t_min_v = Int(thirdTimeValue[0]) {
                    t_min = t_min_v
                }
                if let t_sec_v = Int(thirdTimeValue[1]) {
                    t_sec = t_sec_v
                }
                if let t_msec_v = Int(thirdTimeValue[2]) {
                    t_msec = t_msec_v
                }
            }
        }
        
        var s_min = 0
        var s_sec = 0
        var s_msec = 0
        if let secondTimeValue = secondTime?.components(separatedBy: ".") {
            if secondTimeValue.count > 2 {
                if let s_min_v = Int(secondTimeValue[0]) {
                    s_min = s_min_v
                }
                if let s_sec_v = Int(secondTimeValue[1]) {
                    s_sec = s_sec_v
                }
                if let s_msec_v = Int(secondTimeValue[2]) {
                    s_msec = s_msec_v
                }
            }
        }
        
        let t_total_msec = (6000*t_min)+(100*t_sec)+(t_msec)
        let s_total_msec = (6000*s_min)+(100*s_sec)+(s_msec)
        
        var total_msec = (t_total_msec)-(s_total_msec)
        
        if total_msec > 0{
            func millisecondsToMinutesSecondsMilliseconds (seconds : Int) -> (Int, Int, Int) {
            return (total_msec / 6000, (total_msec % 6000) / 100, (total_msec % 6000) % 100)
            }
        }else{
            total_msec = 0
        }
        
        if (total_msec % 6000) / 100 > 9 && (total_msec % 6000) % 100 > 9{
            let result = "\(total_msec / 6000).\((total_msec % 6000) / 100).\((total_msec % 6000) % 100)"
            return result
        }else if (total_msec % 6000) / 100 > 9 && (total_msec % 6000) % 100 < 10 {
            let result2 = "\(total_msec / 6000).\((total_msec % 6000) / 100).0\((total_msec % 6000) % 100)"
            return result2
        }else if (total_msec % 6000) / 100 < 10 && (total_msec % 6000) % 100 > 9{
            let result3 = "\(total_msec / 6000).0\((total_msec % 6000) / 100).\((total_msec % 6000) % 100)"
            return result3
        }else{
            let result4 = "\(total_msec / 6000).0\((total_msec % 6000) / 100).0\((total_msec % 6000) % 100)"
            return result4
        }
        
        print(total_msec / 6000, (total_msec % 6000) / 100, (total_msec % 6000) % 100)
    }
    

    func calcDiff3() -> String {
        let formValues = self.form.values()
        let thirdTime = formValues["thirdTime"] as? String
        let fourthTime = formValues["fourthTime"] as? String
        
        // fourth - third
        var f_min = 0
        var f_sec = 0
        var f_msec = 0
        if let fourthTimeValue = fourthTime?.components(separatedBy: ".") {
            if fourthTimeValue.count > 2 {
                if let f_min_v = Int(fourthTimeValue[0]) {
                    f_min = f_min_v
                }
                if let f_sec_v = Int(fourthTimeValue[1]) {
                    f_sec = f_sec_v
                }
                if let f_msec_v = Int(fourthTimeValue[2]) {
                    f_msec = f_msec_v
                }
            }
        }
        
        var t_min = 0
        var t_sec = 0
        var t_msec = 0
        if let thirdTimeValue = thirdTime?.components(separatedBy: ".") {
            if thirdTimeValue.count > 2 {
                if let t_min_v = Int(thirdTimeValue[0]) {
                    t_min = t_min_v
                }
                if let t_sec_v = Int(thirdTimeValue[1]) {
                    t_sec = t_sec_v
                }
                if let t_msec_v = Int(thirdTimeValue[2]) {
                    t_msec = t_msec_v
                }
            }
        }
        
        let f_total_msec = (6000*f_min)+(100*f_sec)+(f_msec)
        let t_total_msec = (6000*t_min)+(100*t_sec)+(t_msec)
        
        var total_msec = (f_total_msec)-(t_total_msec)
        
        if total_msec > 0{
            func millisecondsToMinutesSecondsMilliseconds (seconds : Int) -> (Int, Int, Int) {
            return (total_msec / 6000, (total_msec % 6000) / 100, (total_msec % 6000) % 100)
            }
        }else{
            total_msec = 0
        }
        
        if (total_msec % 6000) / 100 > 9 && (total_msec % 6000) % 100 > 9{
            let result = "\(total_msec / 6000).\((total_msec % 6000) / 100).\((total_msec % 6000) % 100)"
            return result
        }else if (total_msec % 6000) / 100 > 9 && (total_msec % 6000) % 100 < 10 {
            let result2 = "\(total_msec / 6000).\((total_msec % 6000) / 100).0\((total_msec % 6000) % 100)"
            return result2
        }else if (total_msec % 6000) / 100 < 10 && (total_msec % 6000) % 100 > 9{
            let result3 = "\(total_msec / 6000).0\((total_msec % 6000) / 100).\((total_msec % 6000) % 100)"
            return result3
        }else{
            let result4 = "\(total_msec / 6000).0\((total_msec % 6000) / 100).0\((total_msec % 6000) % 100)"
            return result4
        }
    
        print(total_msec / 6000, (total_msec % 6000) / 100, (total_msec % 6000) % 100)
    }
    
    func saveRecord() {
        
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

