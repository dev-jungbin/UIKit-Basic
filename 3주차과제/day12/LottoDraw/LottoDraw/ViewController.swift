//
//  ViewController.swift
//  LottoDraw
//
//  Created by 1v1 on 2021/01/07.
//

import UIKit
import FMDB
import FirebaseDatabase
class ViewController: UIViewController, UITableViewDataSource {
    var ref: DatabaseReference!
    var ref2: DatabaseReference!
    var refHandle : DatabaseHandle!

    @IBOutlet weak var tableView: UITableView!
    var lottoNumbers = Array<Array<Int>>()

    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref2 = ref.child("users/numbers")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("옵저버 등록")
        refHandle = ref2.observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [[Int]]
          print(postDict)
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lottoNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for: indexPath) as! LottoCell
        let row = indexPath.row
        cell.number1.text = "\(lottoNumbers[row][0])"
        cell.number2.text = "\(lottoNumbers[row][1])"
        cell.number3.text = "\(lottoNumbers[row][2])"
        cell.number4.text = "\(lottoNumbers[row][3])"
        cell.number5.text = "\(lottoNumbers[row][4])"
        cell.number6.text = "\(lottoNumbers[row][5])"
        return cell
    }
    @IBAction func doDraw(_ sender: Any) {
        lottoNumbers = Array<Array<Int>>()
        
        var originalNumbers = Array(1...45)
        var index = 0
        
        for _ in 0...4{
            var originalNumbers = Array(1...45)
            var columnArray = Array<Int>()
            for _ in 0...5{
                index = Int.random(in: 0..<originalNumbers.count)
                columnArray.append(originalNumbers[index])
                originalNumbers.remove(at: index)
            }
            columnArray.sort()
            lottoNumbers.append(columnArray)
        }
        tableView.reloadData()
    }
    @IBAction func doSave(_ sender: Any) {
        print("save")
        
        ref.child("users/numbers").setValue(lottoNumbers){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
              print("Data could not be saved: \(error).")
            } else {
                let alertVC = UIAlertController(title: "Complete", message: "Data saved!!", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
              print("Data saved successfully!")
            }
          }
       
    }
    @IBAction func doLoad(_ sender: Any) {
        lottoNumbers = Array<Array<Int>>()
        ref2.observeSingleEvent(of: .value){ (snapshop) in
            let data = snapshop.value as? [[Int]]
            print(data)
            self.lottoNumbers = data!
            self.tableView.reloadData()
        }
    }
}

