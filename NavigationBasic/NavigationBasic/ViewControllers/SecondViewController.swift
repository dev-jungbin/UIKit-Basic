//
//  SecondViewController.swift
//  NavigationBasic
//
//  Created by 1v1 on 2021/01/07.
//

import UIKit

class SecondViewController: UIViewController{
    @IBOutlet weak var label: UILabel!
    var label_text = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = label_text
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("3rd 뷰로 넘어갑니다")
    }
    
}
