//
//  ThirdViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/18.
//  Copyright © 2019 kanon. All rights reserved.

//入力するところをタップしたときに単位の後にカーソルが来てしまう。入力するときにイライラするので単位を固定させるか、カーソルが単位の前に来るようにしたい。

import UIKit
import Eureka
import FirebaseDatabase



class AddMenuViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var ref: DatabaseReference!
    
    var distance :Int = 0
    
    var times :Int = 0
    
    var sets = 0
    
    var calcTotalDistance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        form +++ Section("メニューの内容")
            <<< TextRow("menuName") {
                $0.title = "メニュー名"
                $0.placeholder = "メニューの名前を入力"
            }
            <<< PickerInlineRow<String>("style") { row in
                row.title = "種目"
                row.options = ["Fr","Ba","Br","Fly","IM"]
                row.value = row.options.first
                }.onChange {[unowned self] row in}
            <<< PickerInlineRow<String>("detail") { row in
                row.title = "詳細"
                row.options = ["選択しない","Hard","Easy","Form","Smooth","Allout"]
                row.value = row.options.first
                }.onChange {[unowned self] row in}
            <<< TextRow("memo") {
                $0.title = "メモ"
                $0.placeholder = ""
            }
            <<< TextRow("distance") {
                $0.title = "距離"
                $0.placeholder = "m"
                self.SaveCode.keyboardType = UIKeyboardType.numberPad
                }.onChange({[unowned self] (row) in
                    if let distanceValue = row.value {
                        self.distance = Int(distanceValue)!
                        self.form.rowBy(tag: "totalLength")?.value = self.calcDistance()
                        self.form.rowBy(tag: "totalLength")?.reload()
                    }
                })
            <<< TextRow("times") {
                $0.title = "本数"
                $0.placeholder = "本"
                self.SaveCode.keyboardType = UIKeyboardType.numberPad
                }.onChange({[unowned self] (row) in
                    if let timesValue = row.value {
                        self.times = Int(timesValue)!
                        self.form.rowBy(tag: "totalLength")?.value = self.calcDistance()
                        self.form.rowBy(tag: "totalLength")?.reload()
                    }
                })
            <<< TextRow("sets") {
                $0.title = "セット数"
                $0.placeholder = "セット"
                self.SaveCode.keyboardType = UIKeyboardType.numberPad
                }.onChange({[unowned self] (row) in
                    if let setsValue = row.value {
                        self.sets = Int(setsValue)!
                        self.form.rowBy(tag: "totalLength")?.value = self.calcDistance()
                        self.form.rowBy(tag: "totalLength")?.reload()
                    }
                })
            <<< TextRow("totalLength") {
                $0.title = "合計距離"
                $0.placeholder = "m"
                }
            <<< TextRow("circle") {
                $0.title = "サークル"
                $0.placeholder = "サークルを入力"
                $0.value = " 分　秒"
            }
            <<< TextRow("setRest") {
                $0.title = "セット間"
                $0.placeholder = "セット間を入力"
                $0.value = " 分　秒"
        }
        
        form +++ Section("タイム")
            <<< TextAreaRow("time")  { row in
                row.placeholder = "タイムを入力"
        }
        
        
        
    }
    
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func calcDistance()->String{
    return String(self.distance * self.times * self.sets)
    }
    
    func saveMenu() {
        
        let ud = UserDefaults.standard
        let formValues = self.form.values()
        
        
        // 過去にメニューが保存されていたら、過去に追加したメニューを取り出して、新しいメニューを追加
        if var menus = ud.array(forKey: "menus") as? [Dictionary<String, String?>] {
            let newMenu: Dictionary<String, String?> = [
                "menuName": formValues["menuName"] as? String,
                "style": formValues["style"] as? String,
                "detail": formValues["detail"] as? String,
                "memo": formValues["memo"] as? String,
                "distance": formValues["distance"] as? String,
                "times": formValues["times"] as? String,
                "sets": formValues["sets"] as? String,
                "totalLength": formValues["totalLength"] as? String,
                "circle": formValues["circle"] as? String,
                "setRest": formValues["setRest"] as? String,
                "time": formValues["time"] as? String
            ]
            menus.append(newMenu)
            ud.set(menus, forKey: "menus")
        } else {
            // メニューが作成されていなかったら新しくめにゅー配列を作ってそれに新しいメニューを追加して保存
            var menus = [Dictionary<String, String?>]()
            let newMenu: Dictionary<String, String?> = [
                "menuName": formValues["menuName"] as? String,
                "style": formValues["style"] as? String,
                "detail": formValues["detail"] as? String,
                "memo": formValues["memo"] as? String,
                "distance": formValues["distance"] as? String,
                "times": formValues["times"] as? String,
                "sets": formValues["sets"] as? String,
                "totalLength": formValues["totalLength"] as? String,
                "circle": formValues["circle"] as? String,
                "setRest": formValues["setRest"] as? String,
                "time": formValues["time"] as? String
            ]
            menus.append(newMenu)
            ud.set(menus, forKey: "menus")
        }
        
        ud.synchronize()
        
    }
    
    @IBAction func save(){
        saveMenu()
        
        let alertController = UIAlertController(title: "保存完了！", message:"メニューの保存が完了しました。メニューリストに戻ります。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
//            let formValues = self.form.values()
//            print(formValues["menuName"] as? String)
            let ud = UserDefaults.standard
            print(ud.object(forKey: "menus"))
            
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
        
}
