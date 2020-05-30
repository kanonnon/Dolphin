//
//  EditMyPageViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/19.
//  Copyright © 2019 kanon. All rights reserved.


import UIKit
import Eureka
import Firebase
import FirebaseDatabase

class SetValueViewController: FormViewController {
    
    var setValue = [SetValue]()
    
    var setValueDate: SetValue!
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        form +++ Section("初期値の設定")
            <<< TextRow("place") {
                $0.title = "練習場所"
                    }
            <<< TextRow("poolType") {
                $0.title = "練習のプールの長さ"
                    }
        }
    
    func saveSetValueData() {
        let formValues = self.form.values()
        let place = formValues["place"] as! String
        let poolType = formValues["poolType"] as? String
        
        let setValueDate = ["place": place,
                    "poolType": poolType] as
                    [String : Any]
        
        self.ref.child("setValueDate").childByAutoId().setValue(setValueDate)
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(){
        saveSetValueData()
        
        let alertController = UIAlertController(title: "設定完了！", message:"入力された初期値を設定しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let storyboard: UIStoryboard = self.storyboard!
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

    }
    
   
    
}
