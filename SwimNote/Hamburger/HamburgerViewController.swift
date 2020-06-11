//
//  HamburgerViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/11/09.
//  Copyright © 2019 kanon. All rights reserved.
//SideMenuの横幅は大体240くらい

import UIKit
import SideMenu
import FirebaseAuth

class HamburgerViewController: UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func twitter() {
        UIApplication.shared.open(URL(string: "https://twitter.com/dolphin_swimapp")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func logout() {
        //アラートの表示
        let alert = UIAlertController(title: "ログアウトします", message: "本当によろしいですか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //OKを押したときのアクション
            do {
                try Auth.auth().signOut()
            } catch let error {
            }
            //ログイン画面への遷移
            //Storyboardを指定
            let signInStoryboard:UIStoryboard = UIStoryboard(name: "SignIn", bundle: nil)
            //生成するViewControllerを指定
            let loginViewController:LoginViewController = signInStoryboard.instantiateInitialViewController() as! LoginViewController
            //表示
            self.present(loginViewController, animated: true, completion: nil)
        }
        let cancelAaction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
            //キャンセルを押したときのアクション
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAaction)
        self.present(alert, animated: true, completion: nil)
    }

}
