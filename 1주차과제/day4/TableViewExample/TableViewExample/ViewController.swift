//
//  ViewController.swift
//  TableViewExample
//
//  Created by 1v1 on 2021/01/08.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var datasource = ["강유진", "강예원", "정정빈", "박세히", "나머지"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        
        cell.textLabel?.text = "\(datasource[row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // 앞에 들여쓰기 안 하고 싶을 때
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { // edit 가능? 안 가능(기본값 true)
        
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        let data = datasource[fromRow]
        datasource.remove(at: fromRow)
        datasource.insert(data, at: toRow)
    }
    
    // 셀 오른쪽 끝에 나타날 버튼들
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnDelete = UIContextualAction(style: .destructive, title: "Del"){(action, view, completion)in // 지우기 액션 실행할때,,
            let row = indexPath.row
            self.datasource.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        
        btnDelete.backgroundColor = .black
        
        return UISwipeActionsConfiguration(actions: [btnDelete])
    }
    
    //셀 왼쪽 시작부분에 나타날 버튼들
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnShare = UIContextualAction(style: .normal, title: "Share"){(action, view, completion) in completion(true)}
        
        return UISwipeActionsConfiguration(actions: [btnShare])
    }

    override func viewDidLoad() {
        //뷰 인스턴스가 메모리에 올라왔고, 아직 화면은 뜨지 않은 상황
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 새로고침!!!
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .cyan
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc func fetchData(_ sender:Any) {
        tableView.refreshControl?.endRefreshing()
    }


    @IBAction func changeEditing(_ sender: UIBarButtonItem) {
        // self.tableView.isEditing = !self.tableView.isEditing
        // toggle swift 4.2 때 추가댐
        self.tableView.isEditing.toggle()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        // 선택하면 선택 바로 풀리게
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

