//
//  EditMyPageViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/19.
//  Copyright © 2019 kanon. All rights reserved.

//保存ボタンを押したらデータを更新したい。Atschoolなど見たが、Euerkaだと値を更新する箇所が一つじゃない（それぞれのrowがあって）から更新の仕方がわからなかった。画像の保存についてはまだ対応できていない。保存ボタンを押して元に戻ったあと通常運転してくれない（ハンバーガーメニューを開くとおかしいことがわかる）からそれをどうにかしたい。

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
                
        }
    
    func saveMyPageData() {
        let formValues = self.form.values()
        let userName = formValues["userName"] as! String
        let selfIntroduce = formValues["selfIntroduce"] as? String
        let S1 = formValues["S1"] as? String
        let bestTime = formValues["bestTime"] as? String
        
        let myPageData = ["userName": userName,
                    "selfIntroduce": selfIntroduce,
                    "S1": S1,
                    "bestTime": bestTime] as
                    [String : Any]
        
        self.ref.child("myPageData").childByAutoId().setValue(myPageData)
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(){
        
        self.saveMyPageData()
        
        let alertController = UIAlertController(title: "変更完了！", message:"入力された内容に変更しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "RootTabVarController") as! UITabBarController
            //let vc = UITabBarController()
            //vc.modalTransitionStyle = .crossDissolve
            self.present(nextView, animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

    }
    
}
