//
//  ImageListViewController.swift
//  FireStorageBasic
//
//  Created by 1v1 on 2021/01/27.
//

import UIKit
import FirebaseDatabase

class ImageListViewController: UIViewController {
    var ref: DatabaseReference!
    var refHandle:DatabaseHandle!
    var imageUrls = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.observe(.value) { (snapshop) in
            
        }
        refHandle = ref.child("users/11abcd3422/images").observe(DataEventType.value, with: { (snapshot) in
            let imageDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.imageUrls = [String]()
            //debugPrint(imageDict)
            for (key, value) in imageDict{
                self.imageUrls.append(value["image_url"]!! as! String)
            }
            print(self.imageUrls)
        })
        
    }
}


extension ImageListViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //self.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        return cell
    }
    
    
}
