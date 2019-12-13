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
    @IBOutlet weak var viewMember: UILabel!
    
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var favourite: UIButton!
    
    var companyDetail: Company!
    
    func configureCell(company: Company) {
        companyDetail = company
        if let url = company.logoUrl {
            logo.kf.setImage(with: url)
        }
        self.company.text = company.company
        website.setTitle(company.website, for: .normal)
        about.text = company.about
        viewMember.text = company.viewMembersTitle
        favourite.isSelected  = companyDetail.isFavourite
        follow.setTitle(companyDetail.isFollowing ? "UNFOLLOW" : "FOLLOW", for: .normal)
    }
    
    @IBAction func showMembers(_ sender: Any) {
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        if let url = companyDetail.websiteUrl {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func follow(_ sender: Any) {
        companyDetail.isFollowing = !companyDetail.isFollowing
        follow.setTitle(companyDetail.isFollowing ? "UNFOLLOW" : "FOLLOW", for: .normal)
    }
    
    @IBAction func markAsFavourite(_ sender: UIButton) {
        favourite.isSelected = !favourite.isSelected
        companyDetail.isFavourite = favourite.isSelected
    }
}
