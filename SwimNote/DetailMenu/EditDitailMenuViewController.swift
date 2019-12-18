//
//  EditDitailMenuViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/14.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Eureka
import Firebase
import FirebaseDatabase

class EditDitailMenuViewController: FormViewController {
    
    var selectedDitailMenu: Dictionary<String, String?>!
    
    @IBOutlet weak var SaveCode: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }
            <<< TextRow("times") {
                $0.title = "本数"
                $0.placeholder = "本"
                self.SaveCode.keyboardType = UIKeyboardType.numberPad
            }
            <<< TextRow("sets") {
                $0.title = "セット数"
                $0.placeholder = "セット"
                self.SaveCode.keyboardType = UIKeyboardType.numberPad
            }
            <<< TextRow("totalLength") {
                $0.title = "合計距離"
                $0.placeholder = "m"
                //$0.value =
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
            <<< TextAreaRow ("time"){ row in
                row.placeholder = "タイムを入力"
        }

        
    }
    


}
