//
//  TableViewCell.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: TableViewCell.self)
    static let nib = UINib(nibName: String(describing: TableViewCell.self), bundle: nil)
    
    @IBOutlet  private weak var ibLabelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update(text: String) {
        ibLabelCell.text = text
    }
    
}
