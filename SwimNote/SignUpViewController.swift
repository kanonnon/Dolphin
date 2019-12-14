//
//  SignUpViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/10.
//  Copyright © 2019 kanon. All rights reserved.

//この画面でサインアップ

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAnalytics

class SignUpViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet weak var backImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "スクリーンショット 2019-12-11 0.29.10.png")
        
        backImageView.image = image

    }
    @IBAction func signup(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil {
                let alertController = UIAlertController(title: "エラーが起きました",
                                                        message:"エラーが起きました。もう一度試してください。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                
                print("登録できませんでした")
            }
                
            else {
                let alertController = UIAlertController(title: "SignUp完了！",
                                                        message:"SignUpが完了しました。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "SignUpStoryBoard") as! RegisterViewController
                    self.present(nextView, animated: true, completion: nil)
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                
                print("登録できました")
            }
        }
    
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }


}
