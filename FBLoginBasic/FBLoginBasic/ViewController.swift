//
//  ViewController.swift
//  FBLoginBasic
//
//  Created by 1v1 on 2021/01/21.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
class ViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                let authError = error as NSError
                print(error.localizedDescription)
                return
            }
         
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            let loginButton = FBLoginButton()
        loginButton.delegate = self
        let width = loginButton.frame.width
        let height = loginButton.frame.height
        let screen_width = self.view.frame.width
        let screen_height = self.view.frame.height
        loginButton.frame = CGRect(x: screen_width/2 - width/2, y: screen_height/2 - height/2, width: width, height: height)
        self.view.addSubview(loginButton)
        print("test")
    }


}

