//
//  WebtoonViewController.swift
//  UIControlExample
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit

class WebtoonViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        self.view.endEditing(true)
    }
}

extension WebtoonViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
