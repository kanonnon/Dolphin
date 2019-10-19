//
//  EditMyPageViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/19.
//  Copyright © 2019 kanon. All rights reserved.

//変更ボタンを押したら元の画面に戻ってマイページが変更されているようにしたい。firebaseに保存するところまではできた。画像の保存はまだできない。

import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseDatabase

class EditMyPageViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var ref: DatabaseReference!
    
    var selectedImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        form +++ Section("アイコン")
            <<< ImageRow() {
                $0.title = "画像"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum, .Camera]
                $0.value = UIImage(named: "heli")
                $0.clearAction = .yes(style: .destructive)
                $0.onChange { [unowned self] row in
                    self.selectedImg = row.value!
                }
        }
                
        form +++ Section("設定")
            <<< TextRow("userName") {
                $0.title = "ユーザーネーム"
                $0.placeholder = "ユーザーネームを編集"
                    }
            <<< TextAreaRow("selfIntroduce") { row in
                row.placeholder = "自己紹介を編集"
            }
            <<< TextRow("S1") {
                $0.title = "S1"
                $0.placeholder = "S1の種目を編集"
                    }
            <<< TextRow("bestTime") {
                $0.title = "ベストタイム"
                $0.placeholder = "S1のベストタイムを編集"
                }
        
        form +++ ButtonRow() {
            $0.title = "この内容に変更"
            $0.onCellSelection { cell, row in
            self.navigationController?.popViewController(animated: true)
                
                self.saveMyPageData()
                
                let alertController = UIAlertController(title: "変更完了！", message:"入力された内容に変更しました。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
                
        }
    
    func saveMyPageData() {
        let formValues = self.form.values()
        let userName = formValues["userName"] as! String
        let selfIntroduce = formValues["selfIntroduce"] as! String
        let S1 = formValues["S1"] as! String
        let bestTime = formValues["bestTime"] as! String
        
        let myPageData = ["userName": userName,
                    "selfIntroduce": selfIntroduce,
                    "S1": S1,
                    "bestTime": bestTime] as
                    [String : Any]
        
        self.ref.child("myPageData").childByAutoId().setValue(myPageData)
    }
    
    
}
