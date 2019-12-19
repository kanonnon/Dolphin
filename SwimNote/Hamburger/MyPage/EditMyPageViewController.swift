//
//  EditMyPageViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/19.
//  Copyright © 2019 kanon. All rights reserved.

//保存ボタンを押したらデータを更新したい。Atschoolなど見たが、Euerkaだと値を更新する箇所が一つじゃない（それぞれのrowがあって）から更新の仕方がわからなかった。画像の保存についてはまだ対応できていない。保存ボタンを押して元に戻ったあと通常運転してくれない（ハンバーガーメニューを開くとおかしいことがわかる）からそれをどうにかしたい。
//TODO画像
//TODOデータの更新


import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseDatabase

class EditMyPageViewController: FormViewController {
    
    var myPage = [MyPage]()
    
    var myPageDate: MyPage!
    
    var ref: DatabaseReference!
    
    var selectedImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        form +++ Section("")
            <<< ButtonRow("この内容に変更") { (row: ButtonRow) in
                row.title = row.tag
                }
                .onCellSelection({ (cell, row) in
                    self.updateMyPage()
                    
                    let alertController = UIAlertController(title: "変更完了！", message:"入力された内容に変更しました。", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        let storyboard: UIStoryboard = self.storyboard!
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
         })
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
                $0.value = myPageDate.userName
                    }
            <<< TextAreaRow("selfIntroduce") { row in
                row.placeholder = "自己紹介を編集"
                row.value = myPageDate.selfIntroduce
            }
            <<< TextRow("S1") {
                $0.title = "S1"
                $0.placeholder = "S1の種目を編集"
                $0.value = myPageDate.S1
                    }
            <<< TextRow("bestTime") {
                $0.title = "ベストタイム"
                $0.placeholder = "S1のベストタイムを編集"
                $0.value = myPageDate.bestTime
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
        
        self.updateMyPage()
        
        let alertController = UIAlertController(title: "変更完了！", message:"入力された内容に変更しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let storyboard: UIStoryboard = self.storyboard!
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

    }
    
    func loadRecords() {
        ref.child("myPageData").observeSingleEvent(of: .value) { snapshot in
            print(snapshot.value as? [String: [String:String]])
            if let data = snapshot.value as? [String: [String:String]]{
                self.myPage = [MyPage]()
                
                for (_, value) in data {
                    let myPage = MyPage()
                    myPage.id = self.ref.childByAutoId().key
                    myPage.userName = value["userName"] as! String
                    myPage.selfIntroduce = value["selfIntroduce"] as! String
                    myPage.S1 = value["S1"] as! String
                    myPage.bestTime = value["bestTime"] as! String
                    
                    self.myPage.append(myPage)
                }
            }
        }
    }
    
    func updateMyPage() {
        let formValues = self.form.values()
        let userName = formValues["userName"] as! String
        let selfIntroduce = formValues["selfIntroduce"] as? String
        let S1 = formValues["S1"] as? String
        let bestTime = formValues["bestTime"] as? String
        
        let menu = ["userName": userName,
                    "selfIntroduce": selfIntroduce,
                    "S1": S1,
                    "bestTime": bestTime] as [String : Any]
        ref.child("competition/\(myPageDate.id)").updateChildValues(menu)
    }
}
