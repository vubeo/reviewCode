//
//  CollectionViewCell.swift
//  do-hoang-vu
//
//  Created by Đỗ Hoàng Vũ on 7/6/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var my_image: UIImageView!
    @IBOutlet weak var my_label: UILabel!
    func displayContent(image : UIImage , title : String) {
        my_image.image = image
        my_label.text = title
    }
}
