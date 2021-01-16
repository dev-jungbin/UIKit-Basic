//
//  ViewController.swift
//  NaverWebtoonExample
//
//  Created by 1v1 on 2021/01/17.
//

import UIKit

class ViewController: UIViewController {
    var titleImages = ["title_01","title_02","title_03","title_04","title_05","title_06"]
    var webtoonData = [
        WebToonData("참교육", "title_01", 3.3, "참굑작가"),
        WebToonData("호위무사", "title_02", 2.3, "우앵"),
        WebToonData("삼국지", "title_03", 3.1, "자까몰라"),
        WebToonData("진삼국", "title_04", 3.7, "어케앎"),
        WebToonData("귀요미", "title_05", 2.3, "조조"),
        WebToonData("사슴", "title_06", 4.3, "미미")

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webToonCell", for: indexPath) as! WebToonCell
        // title, 별점, 작가명 채우기
        let data = webtoonData[indexPath.row]
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "\(data.rating!)"
        cell.authorLabel.text = data.author
        // 타이틀 이미지 변경
        cell.titleImage.image = UIImage(named: data.title_image)
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
