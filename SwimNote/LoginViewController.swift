//
//  LoginViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/10.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet weak var backImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "スクリーンショット 2019-12-11 0.29.10.png")
        
        backImageView.image = image
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                let alertController = UIAlertController(title: "Loginできませんでした",
                                                        message:"メールアドレスとパスワードが一致しません。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                print("ログインできませんでした")
            }
            else {
                let alertController = UIAlertController(title: "Login完了！",
                                                        message:"Loginが完了しました。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    let storyboard: UIStoryboard = self.storyboard!
                    let nextView = storyboard.instantiateViewController(withIdentifier: "SignUpStoryBoard") as! RegisterViewController
                    self.present(nextView, animated: true, completion: nil)
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                print("ログインできました")
            }
        }
    }
    
    
}
