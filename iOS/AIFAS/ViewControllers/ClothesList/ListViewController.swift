//
//  ListViewController.swift
//  AIFAS
//
//  Created by 冨平準喜 on 2021/06/14.
//

import UIKit

class ListViewController: UIViewController, Instantiatable,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var wearCollectionView: UICollectionView!
    
    //1行に何個表示させるか
    private let itemsPerRow: CGFloat = 3
    //周りの余白
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wearCollectionView.delegate = self
        wearCollectionView.dataSource = self
        
    }
    
    //colectionViewの設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //とりあえず
        return 10
    }
    
    // セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let photoImageView = cell.viewWithTag(1) as! UIImageView
        
        cell.backgroundColor = .white  // セルの色
        
        return cell
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        // 2
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
}

