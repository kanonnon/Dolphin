//
//  GraphViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/09/15.
//  Copyright © 2019 kanon. All rights reserved.

//とりあえずどんなものかを見るために調べたコードをコピペしてみた。RecordViewControllerで入力した日付をx軸、タイムをy軸に表したい。タイムはy軸の正方向にタイムが速くつまり、数が小さくなるようにしたい。グラフのy軸の値はグラフにする種目によって大幅に異なってくるから、そのメモリを自動的に変えることは可能か？CreatGraphViewControllerでユーザーが選択したデータの折れ線グラフを作りたい。線を何本も引けるようにしたい。
//TODU大会記録の値をここに渡してグラフを作る

import UIKit
import Charts
import Firebase

class GraphViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var graph = [Graph]()
    
    var graphDate: Graph!
//    @IBOutlet var iosChartsFigure: LineChartView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        var rect = view.bounds
        rect.origin.y += 20
        rect.size.height -= 20

//        iosChartsFigure.leftAxis.axisMaximum = 30
//        iosChartsFigure.leftAxis.axisMinimum = 50

        
        let chartView = LineChartView(frame: rect)
        chartView.leftAxis.inverted = true
        
        let entries = [
            BarChartDataEntry(x: 1, y: 31.78),
            BarChartDataEntry(x: 2, y: 30.45),
            BarChartDataEntry(x: 3, y: 30.96),
            BarChartDataEntry(x: 4, y: 30.26),
            BarChartDataEntry(x: 5, y: 29.84),
            BarChartDataEntry(x: 6, y: 29.23)
        ]
        
        let set = LineChartDataSet(entries: entries, label: "50mFr")
        chartView.data = LineChartData(dataSet: set)
        view.addSubview(chartView)

    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func loadRecords() {
        // データベースからデータを読み込んでrecords配列に入れる。そのあと、tableViewの表示を更新。
        ref.child("graph").observeSingleEvent(of: .value) { snapshot in
            
            if let data = snapshot.value as? [String: [String:Any]]{
                
                self.graph = [Graph]()
                
                for (_, value) in data {
                    let graph = Graph()
                    graph.name = value["name"] as! String
                    graph.max = value["max"] as! String
                    graph.min = value["min"] as! String
                    graph.color = value["color"] as! String
                    
                    self.graph.append(graph)
                }
            }
        }
    }
}
