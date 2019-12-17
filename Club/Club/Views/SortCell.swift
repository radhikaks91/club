//
//  SortCell.swift
//  Club
//
//  Created by Radhika KS01 on 16/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

class SortCell: UITableViewCell {

    @IBOutlet weak var sortType: UILabel!
    
    func configureCell(sort: String) {
        sortType.text = sort
    }
}
