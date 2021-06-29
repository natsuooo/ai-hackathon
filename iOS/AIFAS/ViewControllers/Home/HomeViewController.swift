//
//  HomeViewController.swift
//  AIFAS
//
//  Created by 佐藤未悠 on 2021/06/19.
//

import UIKit


class HomeViewController: UIViewController ,Instantiatable, UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.layer.cornerRadius = 20.0
        libraryButton.layer.cornerRadius = 20.0
    }
    

    @IBAction func toCamera(_ sender: Any) {
        // カメラ画面に移動
        let vc = CameraViewController.instantiateFromStoryboard()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func toLibrary(_ sender: Any) {
        //ライブラリ画面に移動
        //フォトライブラリの時も一応使えない機種とで分けておく
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            let picker = UIImagePickerController()
            //フォトライブラリから引っ張ってくる
            picker.sourceType = .photoLibrary
            picker.delegate = self
            //picker.allowsEditing = true ←　編集できるようになる
            self.present(picker, animated: true, completion: nil)

        } else {
            print("この機種ではフォトライブラリは使えません")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //pickerからUIImage型として画像データを取り出す
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //縦横比を維持しながらリサイズしてくれる
        let resizedImage = selectedImage.resized(toWidth: 300)
        //pickerした後はそのpickerを閉じる
        picker.dismiss(animated: true, completion: nil)
        let vc = EditViewController.instantiateFromStoryboard()
        vc.image = resizedImage
        present(vc, animated: true, completion: nil)
        //アップロードするにはUIImage型からデータ型に変えないといけない
        //let data = resizedImage?.pngData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//extensionにすることで１つの画像だけでなく他の画像でも使うことができる
//UIImage型のものは.resizedが使えるようになる
extension UIImage {
    //widthを入力して画像を返してくれるresized関数の作成
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
