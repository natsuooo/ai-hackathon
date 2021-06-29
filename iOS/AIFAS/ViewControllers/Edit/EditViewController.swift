//
//  EditViewController.swift
//  AIFAS
//
//  Created by 佐藤未悠 on 2021/06/20.
//

import UIKit

class EditViewController: UIViewController ,Instantiatable,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var image : UIImage?
    
    @IBOutlet var CollectionView : UICollectionView!
    @IBOutlet weak var myImage: UIImageView!
    
    
    let genreList = [
        "半袖",
        "長袖",
        "パーカー",
        "ワンピース",
        "シャツ",
        "タンクトップ"
    ]
    
    @IBOutlet weak var toListButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cellの登録
        let nib = UINib(nibName: "CustomUICollectionViewCell", bundle: Bundle.main)
        CollectionView.register(nib, forCellWithReuseIdentifier: "Cell") as?  CustomUICollectionViewCell
        
        //imageを表示させる
        myImage.image = image
        
        // Cellに使われるクラスを登録.
        CollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        CollectionView.backgroundColor = UIColor.clear
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        self.view.addSubview(CollectionView)
    }
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //一旦これ
        print("Num: \(indexPath.row)")
    }
    //セルの個数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomUICollectionViewCell
        print(indexPath.row)
        cell.textLabel?.text = genreList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    @IBAction func toShare(_ sender: Any) {
        let vc = ShareViewController.instantiateFromStoryboard()
        present(vc, animated: true, completion: nil)
    }
    @IBAction func toList(_ sender: Any) {
        // 服の選択画面に移動
        let vc = ListViewController.instantiateFromStoryboard()
        present(vc, animated: true, completion: nil)
    }
    @IBAction func toBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

