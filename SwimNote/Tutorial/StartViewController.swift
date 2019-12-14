//
//  ViewController.swift
//  SwimNote
//
//  Created by 雨宮佳音 on 2019/12/11.
//  Copyright © 2019 kanon. All rights reserved.

//初回のアプリ起動時に横にスクロールできるようにアプリの紹介画面を作る
//TODO機種によって画面が不完全にならないよう気をつける

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    @IBOutlet var scrollImage: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scrollViewの画面表示サイズを指定
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 25, width: self.view.frame.size.width, height: self.view.frame.height))
        // scrollViewのサイズを指定（幅は1メニューに表示するViewの幅×ページ数）
        scrollView.contentSize = CGSize(width: self.view.frame.size.width*3, height: self.view.frame.height)
        // scrollViewのデリゲートになる
        scrollView.delegate = self as UIScrollViewDelegate
        // メニュー単位のスクロールを可能にする
        scrollView.isPagingEnabled = true
        // 水平方向のスクロールインジケータを非表示にする
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        // scrollView上にUIImageViewをページ分追加する(3ページ分)
        let imageView1 = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height, image: "tutorialImage1.PNG")//TODO写真を入れる
        scrollView.addSubview(imageView1)
        
        let imageView2 = createImageView(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.height, image: "tutorialImage2.PNG")//TODO写真を入れる
        scrollView.addSubview(imageView2)
        
        let imageView3 = createImageView(x: self.view.frame.size.width*2, y: 0, width: self.view.frame.size.width, height: self.view.frame.height, image: "tutorialImage3.PNG")//TODO写真を入れる
        scrollView.addSubview(imageView3)
        
        // pageControlの表示位置とサイズの設定
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 575, width: self.view.frame.size.width, height: 30))
        // pageControlのページ数を設定
        pageControl.numberOfPages = 3
        // pageControlのドットの色
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        // pageControlの現在のページのドットの色
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.addSubview(pageControl)

    }
    
    // UIImageViewを生成
    func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: String) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        let image = UIImage(named:  image)
        imageView.image = image
        return imageView
    }
}
    // scrollViewのページ移動に合わせてpageControlの表示も移動させる
    extension ViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        }
        
        
    
}
