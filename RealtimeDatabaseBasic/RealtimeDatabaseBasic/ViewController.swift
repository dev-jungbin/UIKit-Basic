//
//  ViewController.swift
//  RealtimeDatabaseBasic
//
//  Created by 1v1 on 2021/01/25.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    var ref2: DatabaseReference!
    var refHandle : DatabaseHandle!
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //FMDB
        /*
         1. 데이터베이스가 저장될 파일을 만든다.
         2. 데이터베이스에 연결
         3. 데이터베이스 초기화
         4. 내용을 기록하고 지우고 수정
         */

        ref = Database.database().reference()
        print("1")
        // 새로 데이터를 넣을 때 setValue
//        guard let key = ref.child("users").childByAutoId().key else { return }
//        let post = ["username": "carrot",
//                    "title": "titless"]
//        let childUpdates = ["/posts/\(key)": post,
//                            "/user/carrot/posts/\(key)/": post]
//        ref.updateChildValues(childUpdates)
//
        // My top posts by number of stars
        let testQuery = (ref.child("users")).queryOrdered(byChild: "username")
        testQuery.observe(.value) { (snapshot) in
            let testDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(testDict)
        }

        /*
            CRUD
            c: Create
            r: Read
            u: Update
            d: Delete
         */
//        ref.child("users/\(key)").setValue(["msg":"hi", "username":"heeee", "date":Int(Date().timeIntervalSince1970)]){
//            (error:Error?, ref:DatabaseReference) in
//            if let error = error {
//              print("Data could not be saved: \(error).")
//            } else {
//                let alertVC = UIAlertController(title: "Complete", message: "Data saved!!", preferredStyle: .alert)
//                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alertVC, animated: true, completion: nil)
//              print("Data saved successfully!")
//            }
//          }
        // 있는 데이터를 수정할 때 updateChildValues
        ref.child("users/1122334455/username").updateChildValues(["test":"aaaa"])
        print("2")
        // 비동기
        // 순차, 분기, 반복
        // 1- > 2 -> 3 -> 4
        // 바뀌면 전체 데이터를 다 가져온다.
        
        // 업데이트 항목을 끊김없이 감시하고 싶을 때
        ref2 = ref.child("users/1122334455")

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면이 나타나기 직전에 관찰자를 설정한다.
        print("옵저버 등록")
        refHandle = ref2.observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
          print(postDict)
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 화면이 사라지고 나면 옵저버를 삭제한다
        print("옵저버 삭제")
        //ref2.removeObserver(withHandle: refHandle)
    }

    @IBAction func pressBtn(_ sender: Any) {
        print("pressed")
        // 내가 어떤 액션을 취했을 때 혹은 특정 순간에 데이터를 한 번만 불러오고 싶을 때
        ref2.observeSingleEvent(of: .value){ (snapshop) in
            let data = snapshop.value as? [String:AnyObject] ?? [:]
            print(data)
        }
    }
    
    @IBAction func removeData(_ sender: Any) {
        print("remove button pressed")
        ref.child("users/1122334455/username").child("date").removeValue(){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              print("Data could not be saved: \(error).")
            } else {
                let alertVC = UIAlertController(title: "Complete", message: "Data removed!!", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
              print("Data remoed successfully!")
            }
          }
    }
}

