//
//  RegisterViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/11.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseDatabase

class RegisterViewController: FormViewController {
    
    @IBOutlet weak var SaveCode: UITextField!
    
    var selectedImg = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

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
                $0.placeholder = "ユーザーネームを設定"
            }
            <<< TextAreaRow("selfIntroduce") { row in
                row.placeholder = "自己紹介を設定"
            }
            <<< TextRow("S1") {
                $0.title = "S1"
                $0.placeholder = "S1の種目を設定"
            }
            <<< TextRow("bestTime") {
                $0.title = "ベストタイム"
                $0.placeholder = "S1のベストタイムを設定"
        }
    }
    
    @IBAction func save(){
        
        //ここにセーブのコーど
        
        let alertController = UIAlertController(title: "変更完了！", message:"入力された内容に変更しました。", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "HowToUse") as! HowToUseViewController
            //let vc = UITabBarController()
            //vc.modalTransitionStyle = .crossDissolve
            self.present(nextView, animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }


}
