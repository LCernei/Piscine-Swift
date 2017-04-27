//
//  CollectionViewCell.swift
//  D03
//
//  Created by LLCereni on 4/25/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    var imageToSave: UIImage = UIImage()
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.black
    }
    
    override func prepareForReuse() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.black
        self.activityIndicator.startAnimating()
        self.imageView.image = nil
    }
}

enum Orientation {
    case horizontal
    case vertical
}
