//
//  MainViewController.swift
//  UIControlExample
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit
class MainViewController: UIViewController {
    
    @IBOutlet weak var btnStackView: UIStackView!
    var selectedIndex:Int = 0
    var previousIndex:Int = 0
    @IBOutlet var tabBtns: [UIImageView]!
    
    var viewControllers = [UIViewController]()
    static let firstTabViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstTapViewController")
    static let secondTabViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondTapViewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for btn in tabBtns{
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapTapped(_:)))
            btn.isUserInteractionEnabled = true
            btn.addGestureRecognizer(tap)
        }
        
        viewControllers.append(MainViewController.firstTabViewController)
        viewControllers.append(MainViewController.secondTabViewController)
        
        //tapTapped(tabBtns[0].gestureRecognizers![0] as! UITapGestureRecognizer)
    }
    
    @objc func tapTapped(_ sender: UITapGestureRecognizer) {
        print("tapped")
        if let tag = sender.view?.tag {
            previousIndex = selectedIndex
            selectedIndex = tag
            
            // 화면 갈아끼기
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            
            let currentVC = viewControllers[selectedIndex]
            currentVC.view.frame = UIApplication.shared.windows[0].frame
            currentVC.didMove(toParent: self)
            self.addChild(currentVC)
            self.view.addSubview(currentVC.view)
            self.view.bringSubviewToFront(btnStackView)
        }
    }
    
}
