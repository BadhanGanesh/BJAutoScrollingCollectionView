//
//  CustomImageCollectionViewCell.swift
//  BJAutoScrollingCollectionViewExample
//
//  Created by BadhanGanesh on 15/01/18.
//  Copyright © 2018 Badhan Ganesh. All rights reserved.
//

import UIKit

class CustomImageCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var imageView:UIImageView!
    
    override func awakeFromNib() {
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
    }
}
