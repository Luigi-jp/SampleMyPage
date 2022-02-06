//
//  ViewController.swift
//  SampleMyPage
//
//  Created by 佐藤瑠偉史 on 2021/10/04.
//

import UIKit

class ViewController: UIViewController {
    
    private let space: CGFloat = 2
    private let column: CGFloat = 3
    
    var safeAreaTop: CGFloat { self.view.safeAreaInsets.top }
    var headerViewHeight: CGFloat!

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: CollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
            // レイアウトの設定
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = space
            layout.minimumInteritemSpacing = space
            collectionView.collectionViewLayout = layout
            
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var mainScrollView: UIScrollView! {
        didSet {
            mainScrollView.delegate = self
        }
    }
    @IBOutlet weak var collectionScrollView: UIScrollView!
    @IBOutlet weak var tabBarStackView: UIStackView!
    @IBOutlet weak var postCollectionView: UICollectionView! {
        didSet {
//            postCollectionView.isScrollEnabled = false
            postCollectionView.bounces = false
        }
    }
    @IBOutlet weak var likePostCollectionView: UICollectionView! {
        didSet {
            likePostCollectionView.isScrollEnabled = false
        }
    }
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        headerViewHeight = headerView.frame.height
        collectionView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let row = indexPath.row
        cell.backgroundColor = UIColor.blue
        cell.label.text = String(row)
        return cell
    }
    
    // Cellの大きさを指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = (self.view.bounds.width / column) - space
        return CGSize(width: cellSize, height: cellSize)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerViewTopConstraint.constant = max(-(scrollView.contentOffset.y + headerViewHeight), -headerViewHeight + 50)
    }
}
