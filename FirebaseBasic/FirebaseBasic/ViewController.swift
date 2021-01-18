//
//  ViewController.swift
//  FirebaseBasic
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit
import FirebaseUI


class ViewController: UIViewController, FUIAuthDelegate {
    @IBOutlet weak var signoutBtn: UIButton!
    let authUI = FUIAuth.defaultAuthUI()
    var handle:AuthStateDidChangeListenerHandle!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = auth.currentUser{
                // 로그인이 되어 있는 상태
                let alertController = UIAlertController(title: "Welcome", message: "\(currentUser.displayName!)! Welcome!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: false, completion: nil)
            } else{
                //로그아웃이 되어 있는 상태
                self.authUI!.delegate = self
                
                let providers: [FUIAuthProvider] = [
                    //FUIGoogleAuth(),
                    //FUIFacebookAuth(),
                    FUIEmailAuth()
                ]
                self.authUI!.providers = providers
                
                let authViewController = self.authUI!.authViewController()
                authViewController.modalPresentationStyle = .fullScreen
                //rauthViewController.setNavigationBarHidden(true, animated: false)
                //authViewController.setToolbarHidden(true, animated: false)
                self.present(authViewController, animated: true, completion: nil)
            }
            self.signoutBtn.setTitle("\(user?.displayName)", for: .normal)
            //            print(auth)
            //            print(user?.email)
            //            print(user?.uid)
        }
    }
    // 로그인이 안 되어 있으면 무조건 로그인 창을 켜라
    // 로그아웃 기능 실행 후에 로그인 창을 띄워라
    // 한쪽에 앱을 켜 놓고 -> 다른 쪽에 로그인을 했다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("sign in")
        print(authDataResult)
    }
    
    
    @IBAction func doSignOut(_ sender: Any) {
        
        try? authUI?.signOut()
        
//        do{
//            try authUI?.signOut()
//        }catch{
//            print("로그아웃 에러")
//        }
    }
    
}

extension FUIAuthBaseViewController{
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
