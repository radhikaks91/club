//
//  MemberCell.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {
    
    var memberDetail: Member!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var favourite: UIButton!
    
    func configureCell(member: Member) {
        memberDetail = member
        name.text = member.fullName
        age.text = "\(member.age)"
        email.text = member.email
        contact.text = member.phone
        favourite.isSelected  = memberDetail.isFavourite
    }
    
    @IBAction func markAsFavourite(_ sender: Any) {
        favourite.isSelected = !favourite.isSelected
        memberDetail.isFavourite = favourite.isSelected
    }
    
    @IBAction func makeCall(_ sender: Any) {
        if let phone = memberDetail.phoneUrl {
            UIApplication.shared.open(phone)
        }
    }
   
    @IBAction func sendMail(_ sender: Any) {
        if let mail = memberDetail.emailUrl {
            UIApplication.shared.open(mail)
        }
    }
    
}
