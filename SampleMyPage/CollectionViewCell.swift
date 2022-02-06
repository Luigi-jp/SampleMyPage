//
//  CollectionViewCell.swift
//  SampleMyPage
//
//  Created by 佐藤瑠偉史 on 2022/02/06.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
