//
//  SignUpViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/10.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAnalytics

class SignUpViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func signup(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil {
                print("登録できませんでした")
            }
                
            else {
                print("登録できました")
            }
        }
    
    }
    

    

    

}
