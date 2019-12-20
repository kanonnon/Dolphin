//
//  CreateDitailGraphViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/20.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class CreateDitailGraphViewController: FormViewController {

    var selectedRecord: Record!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        form +++ Section("グラフの設定")
            <<< TextRow("name") {
                $0.title = "グラフの名前"
                $0.placeholder = "ｸﾞﾗﾌの名前を入力"
            }
            <<< TextRow("max") {
                $0.title = "グラフの最大値"
                $0.placeholder = "0.00.00の形で入力"
            }
            <<< TextRow("min") {
                $0.title = "グラフの最小値"
                $0.placeholder = "0.00.00の形で入力"
            }
            <<< PickerInlineRow<String>("color") { row in
                row.title = "グラフの色"
                row.options = ["赤","ピンク","オレンジ","黄色","緑","水色","青"]
                row.value = row.options.first
                }.onChange {[unowned self] row in}
            
          
        
    }
    
    func saveGraph() {
        let formValues = self.form.values()
        let name = formValues["name"] as! String
        let max = formValues["max"] as! String
        let min = formValues["min"] as! String
        let color = formValues["color"] as! String
        
        
        let menu = ["name": name,
                    "max": max,
                    "min": min,
                    "color": color,] as [String : Any]
        
        self.ref.child("graph").childByAutoId().setValue(menu)
    }
    
    @IBAction func save(){
        saveGraph()
        let alertController = UIAlertController(title: "作成完了！", message:"グラフを作成しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let storyboard: UIStoryboard = self.storyboard!
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
