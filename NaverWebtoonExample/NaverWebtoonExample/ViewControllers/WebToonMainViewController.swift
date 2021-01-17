//
//  WebToonMainViewController.swift
//  NaverWebtoonExample
//
//  Created by 1v1 on 2021/01/17.
//

import UIKit

class WebToonMainViewController: UIViewController {
    @IBOutlet weak var bannerScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerViewController = BannerViewController()
        bannerScrollView.addSubview(bannerViewController.view)
        bannerScrollView.contentSize = bannerViewController.view.frame.size
    }
}
