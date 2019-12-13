//
//  CompanyCell.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var website: UIButton!
    
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var favourite: UIButton!
    
    func configureCell(company: Company) {
        if let url = URL(string: company.logo) {
            self.logo.kf.setImage(with: url)
        }
        self.company.text = company.company
        self.website.titleLabel?.text = company.website
        self.about.text = company.about
    }
    
    @IBAction func follow(_ sender: Any) {
    }
    
    @IBAction func markAsFavourite(_ sender: Any) {
    }
}
