//
//  ViewController.swift
//  FireStoreBasic
//
//  Created by 1v1 on 2021/01/25.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Add a new document in collection "cities"
        db.collection("team members").document("세희").setData([
            "name": "박세희",
            "major": "디미",
            "num": "444"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
      
        
    }


}

