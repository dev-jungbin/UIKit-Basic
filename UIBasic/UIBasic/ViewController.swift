//
//  ViewController.swift
//  UIBasic
//
//  Created by 1v1 on 2021/01/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var labelBMI: UILabel!
    @IBOutlet weak var textField01: UITextField!
    @IBOutlet weak var textField02: UITextField!
    @IBOutlet weak var btn01: UIButton!
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doConvert(_ sender: Any) {
        if let height = Double(textField01.text!), let weight = Double(textField02.text!){
            labelBMI.text = String(weight / pow((height/100),2))
        }
        textField01.resignFirstResponder() // 키보드 내리기
    }
    
    @IBAction func dismissKeyboard(_ sender:Any){ // View 터치했을 때
        textField01.resignFirstResponder() // 키보드 내리기
    }
    
    /*
     키(cm)
     체중(kg)
     bmi = 체중/(키(m)의 제곱)
     */

}

