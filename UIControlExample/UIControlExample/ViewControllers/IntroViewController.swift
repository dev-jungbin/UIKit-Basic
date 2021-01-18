//
//  ViewController.swift
//  UIControlExample
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit
import SwiftyGif
class IntroViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do{
            let gif = try UIImage(gifName: "intro.gif")
            self.logoImageView.setGifImage(gif, loopCount: -1) // Will loop forever
        } catch{
            print(error)
        }
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ (timer) in
            // 인트로 끝나고 넘기기
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController"){
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }
        
    }

}

