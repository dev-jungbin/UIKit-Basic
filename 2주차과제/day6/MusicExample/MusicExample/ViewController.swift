//
//  ViewController.swift
//  MusicExample
//
//  Created by 1v1 on 2021/01/17.
//

import UIKit

class ViewController: UIViewController {
    var titleImages = ["title_01","title_02","title_03","title_04","title_05","title_06"]
    var musicData = [
        MusicData("난춘", "title_01", 3.3, "새소년"),
        MusicData("긴 꿈", "title_02", 2.3, "새소년"),
        MusicData("파도", "title_03", 3.1, "새소년"),
        MusicData("검은 해", "title_04", 3.7, "새소년"),
        MusicData("고양이", "title_05", 2.3, "새소년"),
        MusicData("집에", "title_06", 4.3, "새소년")

    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCell
        let data = musicData[indexPath.row]
        cell.songTitleLabel.text = data.title
        cell.songRatingLabel.text = "\(data.rating!)"
        cell.artistLabel.text = data.singer
        // 타이틀 이미지 변경
        cell.albumImage.image = UIImage(named: data.title_image)
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
        
    }

}

