//
//  Company.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import Foundation

struct Company: Codable {
    var _id: String
    var company: String
    var website: String
    var logo: String
    var about: String
    var members: [Member]
    
    var logoUrl: URL? {
        return URL(string: "https://placehold.it/400x150/ADD8E6/FFFFFF/?text=\(company)")
    }
    var websiteUrl: URL? {
        return URL(string: "https://\(website)")
    }
    var viewMembersTitle: String? {
        return "View Members (\(members.count))"
    }
    
    var isFollowing: Bool {
        get {
            let key = "following_\(_id)"
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            let key = "following_\(_id)"
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    var isFavourite: Bool {
        get {
            let key = "favourite_\(_id)"
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            let key = "favourite_\(_id)"
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct Member: Codable {
    var _id: String
    var name: Name
    var age: Int
    var email: String
    var phone: String
}

struct Name: Codable {
    var first: String
    var last: String
}
