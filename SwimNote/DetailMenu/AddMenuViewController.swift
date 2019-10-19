//
//  ThirdViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/08/18.
//  Copyright © 2019 kanon. All rights reserved.

//入力するところをタップしたときに単位の後にカーソルが来てしまう。入力するときにイライラするので単位を固定させるか、カーソルが単位の前に来るようにしたい。ここで入力したデータは旦端末上のみに保存にして、練習メニューの概要を保存するときに同時にfirebaseに保存する。

import UIKit
import Eureka
import FirebaseDatabase



class AddMenuViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var ref: DatabaseReference!
    
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
                $0.placeholder = "距離を入力"
                $0.value = "m"
                self.SaveCode.keyboardType = UIKeyboardType.numberPad
            }
            <<< TextRow("times") {
                $0.title = "本数"
                $0.placeholder = "本数を入力"
                $0.value = "本"
            }
            <<< TextRow("sets") {
                $0.title = "セット数"
                $0.placeholder = "セット数を入力"
                $0.value = "セット"
            }
            <<< TextRow("totalLength") {
                $0.title = "合計距離"
                $0.placeholder = "合計距離を入力"
                $0.value = "m"
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
            <<< TextAreaRow { row in
                row.placeholder = "タイムを入力"
        }
        
        
        
    }
    
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveMenu() {
        
        let ud = UserDefaults.standard
        let formValues = self.form.values()
        ud.set(formValues["menuName"] as? String, forKey: "menuName")
        ud.set(formValues["style"] as! String, forKey: "style")
        ud.set(formValues["detail"] as! String, forKey: "detail")
        ud.set(formValues["memo"] as? String, forKey: "memo")
        ud.set(formValues["distance"] as? String, forKey: "distance")
        ud.set(formValues["times"] as? String, forKey: "times")
        ud.set(formValues["sets"] as? String, forKey: "sets")
        ud.set(formValues["totalLength"] as? String, forKey: "totalLength")
        ud.set(formValues["circle"] as? String, forKey: "circle")
        ud.set(formValues["setRest"] as? String, forKey: "setRest")
        ud.synchronize()
        
//        let formValues = self.form.values()
//        let menuName = formValues["menuName"] as! String
//        let style = formValues["style"] as! String
//        let detail = formValues["detail"] as! String
//        let memo = formValues["memo"] as! String
//        let length = formValues["length"] as! String
//        let times = formValues["times"] as! String
//        let sets = formValues["sets"] as! String
//        let totalLength = formValues["totalLength"] as! String
//        let circle = formValues["circle"] as! String
//        let setRest = formValues["setRest"] as! String
//
//        let menu = ["menuName":  menuName,
//                    "style": style,
//                    "detail": detail,
//                    "memo": memo,
//                    "length": length,
//                    "times": times,
//                    "sets":  sets,
//                    "totalLength": totalLength,
//                    "circle": circle,
//                    "setRest": setRest,
//                    "time": time] as [String : Any]
//
//        self.ref.child("detailMenu").childByAutoId().setValue(menu)
    }
    
    @IBAction func save(){
        saveMenu()
        
        let alertController = UIAlertController(title: "保存完了！", message:"メニューの保存が完了しました。メニューリストに戻ります。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
