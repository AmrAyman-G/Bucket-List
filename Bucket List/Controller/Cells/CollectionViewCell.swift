//
//  CollectionViewCell.swift
//  Bucket List
//
//  Created by amr on 06/06/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var ViewNav: UIView!
    let fC = Func()
    override func awakeFromNib() {
        super.awakeFromNib()
        fC.ViewUi(view: ViewNav)
        
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: ViewNav.frame.height - 5, width: ViewNav.frame.width - 50, height: 2.0)
//        bottomLine.backgroundColor = UIColor.purple.cgColor
//        ViewNav.layer.addSublayer(bottomLine)
        // Initialization code
    }

}
