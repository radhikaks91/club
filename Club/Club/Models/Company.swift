//
//  Company.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import Foundation

struct Company: Codable {
    var id: String
    var company: String
    var website: String
    var logo: String
    var about: String
    var members: [Member]
}

struct Member: Codable {
    var id: String
    var name: Name
    var age: Int
    var email: String
    var phone: String
}

struct Name: Codable {
    var first: String
    var last: String
}