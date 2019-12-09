//
//  FinalMenuViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/09.
//  Copyright © 2019 kanon. All rights reserved.
//

import UIKit

class FinalMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var finalMenu = [["name":"アプリを紹介する","imageName":"icons8-コピー-48.png@2x.jpg"],
                     ["name":"アプリの意見を送る","imageName":"icons8-メール-48.png@2x.jpg"],
                     ["name":"アプリを評価する","imageName":"icons8-apple-app-store-100.png@2x.jpg"],
                    ["name":"使い方を見る","imageName":"icons8-質問する-48.png@2x.jpg"],
                    ["name":"Twitterをフォローする","imageName":"icons8-twitter-(四角)-48.png@2x.jpg"]]
    
    @IBOutlet var finalMenuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データソースメソッドをこのファイル内で処理する
        finalMenuTableView.dataSource = self
        
        //デリゲートメソッドをselfに任せる
        finalMenuTableView.delegate = self
        
        //TableViewの不要な線を消す
        finalMenuTableView.tableFooterView = UIView()
        
        //画面をしっかり表示させる
        finalMenuTableView.rowHeight = 64
        
        //カスタムセルの登録
        let nib = UINib(nibName: "FinalMenuTableViewCell", bundle: Bundle.main)
        finalMenuTableView.register(nib, forCellReuseIdentifier: "finalMenuCell")

        
    }
    
    //cellの個数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalMenu.count
    }
    //TableViewに表示するデータの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //idをつけたCellの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "finalMenuCell") as! FinalMenuTableViewCell
        
        //表示内容を決める
        let imageName = finalMenu[indexPath.row]["imageName"]
        cell.finalMenuView.image = UIImage(named: imageName!)
        cell.finalMenuLabel.text = finalMenu[indexPath.row]["name"]
        
        //cellをかえす
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toIntroduce", sender: nil)
        } else if indexPath.row == 4 {
            let url = NSURL(string: "https://twitter.com/programmer_swim")
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        } else if indexPath.row == 1{
            let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdw7XoVeVHN3ACMpav9DTUsHW8JauYGCQnIRFzuiCqzvCcF7Q/viewform")
            if UIApplication.shared.canOpenURL(url! as URL){
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        } else if indexPath.row == 2{
             performSegue(withIdentifier: "toIntroduce", sender: nil)
        } else if indexPath.row == 3{
            performSegue(withIdentifier: "toIntroduce", sender: nil)
        }
        
        
        //選択状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let introduceViewController = segue.destination as! IntroduceViewController
        let selectedIndex = finalMenuTableView.indexPathForSelectedRow!
        introduceViewController.selectedName = finalMenu[selectedIndex.row]["name"]!
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }

}
