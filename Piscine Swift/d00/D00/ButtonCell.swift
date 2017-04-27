//
//  ButtonCell.swift
//  D00
//
//  Created by lcernei on 4/22/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    
    @IBOutlet weak private var textLabel: UILabel!
    
    func configure(text: String) {
        textLabel.text = text
    }
    
    var defaultColor: UIColor = UIColor.white {
        didSet {
            contentView.backgroundColor = defaultColor
        }
    }
    
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    func flash() {
        contentView.backgroundColor = UIColor.gray
        UIView.animate(withDuration: 0.5) {
            self.contentView.backgroundColor = self.defaultColor
        }
    }
}
