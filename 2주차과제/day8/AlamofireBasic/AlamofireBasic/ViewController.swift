//
//  ViewController.swift
//  AlamofireBasic
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class ViewController: UIViewController {

    var person_data = [PersonInfo]()
    var indicator:NVActivityIndicatorView!
    
    @IBOutlet weak var personTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), type: .lineScaleParty, color: .gray, padding: self.view.frame.width/2 - 20)
        indicator.backgroundColor = UIColor.black.withAlphaComponent(0.4) 
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        getData()
    }
    
    func getData(){
        print("Start Loading")
        self.indicator.startAnimating ()

        let headers: HTTPHeaders = [
            "app-id": "6004598b23fa551fb5ed3dda"
        ]
        AF.request("https://dummyapi.io/data/api/user?limit=10", headers: headers).responseJSON { response in
            //debugPrint(response)
            switch response.result {
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let dummy_data = try decoder.decode(DummyData.self, from: jsonData)
                    self.person_data = dummy_data.data
                    self.personTableView.reloadData()
                    
                    print("finish parsing")
                } catch{
                    debugPrint(error)
                }
            case .failure(let data):
                print("fail")
            default:
                return
            }
            self.indicator.stopAnimating()
        }
        print("Finish Loading")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.personTableView.indexPathForSelectedRow?.first{
            let person_info = person_data[indexPath]
            print(person_info.id)
            if let vc = segue.destination as? DetailController{
                vc.user_id = person_info.id
        }
        }
    }

}


extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        let data = person_data[indexPath.row]
        if let url = data.picture {
            cell.profileImage.af.setImage(withURL: url)
        }
        
        cell.idLabel.text = data.id
        cell.nameLabel.text = data.firstName
        cell.emailLabel.text = data.email
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
