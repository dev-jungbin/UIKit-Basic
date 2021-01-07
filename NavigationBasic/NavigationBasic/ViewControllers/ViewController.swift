//
//  ViewController.swift
//  NavigationBasic
//
//  Created by 1v1 on 2021/01/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var label_data = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    override func viewWillAppear(_ animated: Bool) {
        label.text = label_data
    }
    override func viewDidAppear(_ animated: Bool) {
//        if let storyboard = self.storyboard{
//            let vc = storyboard.instantiateViewController(identifier: "autoView")
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // 데이터 넘기기
        // 화면 전환이 일어나기 전에 하는 일
        if let destination = segue.destination as? SecondViewController{
            destination.label_text = "넘겨받은 데이터"
        }
    }

}


