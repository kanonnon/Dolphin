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

class GraphViewController: UIViewController {
    
     let data:[Double] = [0,1,1,2,3,5,8,13]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x:0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 30)
        let chartView = LineChartView(frame: rect)
        
        var entry = [ChartDataEntry]()
        
        for (i, d) in data.enumerated() {
            entry.append(ChartDataEntry(x: Double(i), y: d ))
        }
        
        let dataSet = LineChartDataSet(entries: entry, label: "data")
        
        chartView.data = LineChartData(dataSet: dataSet)
        
        self.view.addSubview(chartView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
}
