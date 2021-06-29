//
//  ShareViewController.swift
//  AIFAS
//
//  Created by 冨平準喜 on 2021/06/14.
//

import UIKit
import Accounts

class ShareViewController: UIViewController, Instantiatable {
    
    open var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!    //@IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    //シェアボタンの処理
    @IBAction func share(_ sender: Any) {
        //今はテキストだけど共有画面は出てくる
        let text = "sample text"
        let items = [text]
        
        // UIActivityViewControllerをインスタンス化
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // UIAcitivityViewControllerを表示
        self.present(activityVc, animated: true, completion: nil)
    }
    
    //Line共有
    @IBAction func shareOnLine(_ sender: Any) {
        let urlscheme: String = "line://msg/text"
        //適当テキスト
        let message = "iPhone"

        // line:/msg/text/(メッセージ)
        let urlstring = urlscheme + "/" + message

        // URLエンコード
        guard let  encodedURL = urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
          return
        }
        // URL作成
        guard let url = URL(string: encodedURL) else {
          return
        }

        if UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (succes) in
              //  LINEアプリ表示成功
            })
          }else{
            UIApplication.shared.openURL(url)
          }
        }else {
          // LINEアプリが無い場合
          let alertController = UIAlertController(title: "エラー",message: "LINEがインストールされていません",preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
          present(alertController,animated: true,completion: nil)
        }
    }
    
    //twitter共有
    @IBAction func shareOnTwitter(_ sender: Any) {
        //シェアするテキストを作成
        let text = "ここに画像も遷移させたい"
        let hashTag = "#AIFAS"
        let completedText = text + "\n" + hashTag
        
        //作成したテキストをエンコード
        let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
        if let encodedText = encodedText,
           let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            UIApplication.shared.open(url)
        }
    }
    
    //インスタグラム共有
    @IBAction func shareOnInstagram(_ sender: Any) {
        
        //インスタグラムは開けるけどインスタの公式アカウントに飛ぶだけ　→ 本当は自分のストーリーに撮った画像と遷移させたい
        let Username =  "instagram" // Your Instagram Username here
            let appURL = URL(string: "instagram://user?username=\(Username)")!
            let application = UIApplication.shared

            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                // if Instagram app is not installed, open URL inside Safari
                let webURL = URL(string: "https://instagram.com/\(Username)")!
                application.open(webURL)
            }
    }
    
    //スナチャ共有　→ できてない
    @IBAction func shareOnSnapchat(_ sender: Any) {
        
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

