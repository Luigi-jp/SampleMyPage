//
//  ViewController.swift
//  SampleMyPage
//
//  Created by 佐藤瑠偉史 on 2021/10/04.
//

import UIKit

class ViewController: UIViewController {
    
    private let reuseCellId = "CollectionViewCell"
    private let headerClassName = "CollectionViewHeader"
    private let reuseHeaderId = "CollectionViewHeader"
    private let space: CGFloat = 2
    private let column: CGFloat = 3

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            // カスタムヘッダの登録
            let headerNib = UINib(nibName: headerClassName, bundle: nil)
            collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderId)
            
            // レイアウトの設定
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = space
            layout.minimumInteritemSpacing = space
//            layout.headerReferenceSize = CGSize(width: collectionView.bounds.width, height: 400)
            collectionView.collectionViewLayout = layout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellId, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    // Cellの大きさを指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = (self.view.bounds.width / column) - space
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let collectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderId, for: indexPath) as? CollectionViewHeader else {
            fatalError("ヘッダーがありません。")
        }
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionViewHeader
        }
        print("ヘッダーなし")
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let header = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: section))
        let headerSize = header.systemLayoutSizeFitting(CGSize(width: collectionView.bounds.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return headerSize
    }
    
//    // 横のスペース？
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return space
//    }
//
//    // 縦のスペース?
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return space
//    }
}

