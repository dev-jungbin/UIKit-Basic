//
//  ViewController.swift
//  FireStorageBasic
//
//  Created by 1v1 on 2021/01/26.
//

import UIKit
import FirebaseStorage
import PhotosUI

class ViewController: UIViewController{
    let storage = Storage.storage()
    var storageRef:StorageReference!
    var imagePicker:UIImagePickerController!
    var file_name:String!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        storageRef = storage.reference()
    }
    
    @IBAction func selectImage(_ sender: Any) {
        print("select")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 취소 버튼 추가
        let action_cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(action_cancel)
        
        // 갤러리 버튼 추가
        let action_gallery = UIAlertAction(title: "Gallery", style: .default){
            (action) in
            print("push gallery button")
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                print("접근 가능")
                self.showGallery()
            case .notDetermined:
                print("권한 요청한 적 없음")
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
                    
                }
            default:
                let alertVC = UIAlertController(title: "권한 필요", message: "사진첩 접근 권한이 필요합니다. 설정 화면에서 설정해 주세요", preferredStyle: .alert)
                let action_settings = UIAlertAction(title: "Go Settings", style: .default) { (action) in
                    print("go settings")
                    if let appSettings = URL(string: UIApplication.openSettingsURLString ) {
                        UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                    }
                }
                let action_cancel = UIAlertAction(title: "Cancel", style: .cancel)
                alertVC.addAction(action_cancel)
                alertVC.addAction(action_settings)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        
        actionSheet.addAction(action_gallery)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        print("upload btn pressed")
        guard let image = imageView.image else {
            let alertVC = UIAlertController(title: "알림", message: "이미지를 선택하고 업로드 기능을 실행하세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            return
        }
        print("이미지 있음")
        if let data = image.pngData() {
            let imageRef = storageRef.child("images/\(file_name!).png")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    print(downloadURL, "upload complete")
                }
            }
        }
    }
}



extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func showGallery(){
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        if let url = info[.imageURL] as? URL {
            file_name = (url.lastPathComponent as NSString).deletingPathExtension
            print(file_name, "filename")
        }
        imageView.image = selectedImage
        
    }
}
