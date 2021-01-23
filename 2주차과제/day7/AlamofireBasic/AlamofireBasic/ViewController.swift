//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var person_data = [DummyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        print("Start Loading")
        
        AF.request("https://jsonplaceholder.typicode.com/posts").responseJSON { response in
            //debugPrint(response)
            switch response.result {
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    var dummy_data = try decoder.decode([DummyData].self, from: jsonData)
                    //print(dummy_data)
                    self.person_data = dummy_data
                    self.tableView.reloadData()
                } catch{
                    debugPrint(error)
                }
            case .failure(let data):
                print("fail")
            default:
                return
            }
        }
        print("Finish Loading")
    }


}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! Cell
        let data = person_data[indexPath.row]
        cell.label.text = data.title
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate{
    
}
