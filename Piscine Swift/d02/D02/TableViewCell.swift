//
//  TableViewCell.swift
//  D02
//
//  Created by LLCereni on 4/25/17.
//  Copyright © 2017 Liviu CERNEI. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}

class RowInfo {
    var name: String = ""
    var date: String = ""
    var description: String = ""
    
    init(name: String, date: String, description: String) {
        self.name = name
        self.date = date
        self.description = description
    }
}
