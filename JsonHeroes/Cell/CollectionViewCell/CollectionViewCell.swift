//
//  CollectionViewCell.swift
//  UICollectionView2
//
//  Created by devsenior on 10/06/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    @IBOutlet private weak var viewCell: UIView!
    @IBOutlet private weak var classImageView: UIImageView!
    
    static let indentifier = "CollectionViewCell"
    
    static func nib() -> UINib {
       return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCell.layer.borderWidth = 2.0
        viewCell.layer.borderColor = UIColor.white.cgColor
    }
    
    func configure(with data: Buff, selectedIndexPath: IndexPath?, indexPath: IndexPath) {
            classImageView.image = UIImage(named: data.image)
            if let selectedIndexPath = selectedIndexPath {
                viewCell.alpha = selectedIndexPath == indexPath ? 1.5 : 0.4
            } else {
                viewCell.alpha = 1.0
            }
    }
//    func configure(with data: Buff, isCellSelected: Bool) {
//        classImageView.image = UIImage(named: data.image)
//       if isCellSelected {
//           viewCell.alpha = 1.0
//           return
//       }
//        
//        if !isCellSelected {
//            viewCell.alpha = 0.5
//        } else {
//            viewCell.alpha = 1.5
//        }
//        
//    }

}
