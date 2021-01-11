//
//  ViewController.swift
//  LottoDraw
//
//  Created by 1v1 on 2021/01/07.
//

import UIKit
import FMDB

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var lottoNumbers = Array<Array<Int>>()

    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileMgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        databasePath = docsDir + "/lotto.db"
        
        if !fileMgr.fileExists(atPath: databasePath){
            let db = FMDatabase(path: databasePath)
            if db.open() {
                let query = "create table if not exists lotto(id integer primary key autoincrement, number1 integer, number2 integer, number3 integer, number4 integer, number5 integer, number6 integer)"
                if !db.executeStatements(query){
                    NSLog("테이블 생성 오류")
                } else{
                    NSLog("테이블 생성 성공")
                }
                db.close()
            }else{
                NSLog("DB 연결 오류")
            }
        }
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
        let db = FMDatabase(path: databasePath)
        if db.open(){
            db.executeUpdate("delete from lotto", withArgumentsIn: []) // 전체 비우기
            if db.hadError(){
                NSLog("DB 초기화 오류")
            }
            
            for numbers in lottoNumbers{
                let query = "insert into lotto(number1, number2, number3, number4, number5, number6) values (\(numbers[0]), \(numbers[1]), \(numbers[2]), \(numbers[3]), \(numbers[4]), \(numbers[5]))"
                db.executeUpdate(query, withArgumentsIn: [])
                if db.hadError(){
                    NSLog("insert 오류")
                }
            }
            tableView.reloadData()
        } else {
            NSLog("DB 연결 오류")
        }
    }
    @IBAction func doLoad(_ sender: Any) {
        lottoNumbers = Array<Array<Int>>()
        let db = FMDatabase(path: databasePath)
        if db.open(){
            let query = "select * from lotto"
            if let result = db.executeQuery(query, withArgumentsIn: []) {
                while result.next(){
                    var columnArray = Array<Int>()
                    columnArray.append(Int(result.int(forColumn: "number1")))
                    columnArray.append(Int(result.int(forColumn: "number2")))
                    columnArray.append(Int(result.int(forColumn: "number3")))
                    columnArray.append(Int(result.int(forColumn: "number4")))
                    columnArray.append(Int(result.int(forColumn: "number5")))
                    columnArray.append(Int(result.int(forColumn: "number6")))
                    lottoNumbers.append(columnArray)
                }
                tableView.reloadData()
            }
        } else {
            NSLog("DB 연결 오류")
        }
    }
}

