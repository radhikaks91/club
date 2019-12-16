//
//  AppConstants.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import Foundation

struct Services
{
    static let fetchCompaniesAndMembers = "https://next.json-generator.com/api/json/get/Vk-LhK44U"
}

struct StoryboardIdentifiers
{
    static let viewMembers = "viewMembers"
    static let companyCell = "companyCell"
    static let memberCell = "memberCell"
}

struct AppStrings {
    static let searchForMembers = "Search for members"
    static let searchForCompanies = "Search for companies"
    static let members = "Members"
    static let company = "Company"
    static let follow = "FOLLOW"
    static let unfollow = "UNFOLLOW"
    static let nameAsc = "Name - Ascending"
    static let nameDesc = "Name - Descending"
    static let ageAsc = "Age - Ascending"
    static let ageDesc = "Age - Descending"
    static let ageNameAsc = "Age & Name - Ascending"
    static let ageNameDesc = "Age & Name - Descending"
    static let sortBy = "Sort By"
}

enum SortOrder: String {
    case nameAsc = "Name - Ascending"
    case nameDesc = "Name - Descending"
    case ageAsc = "Age - Ascending"
    case ageDesc = "Age - Descending"
    case ageNameAsc = "Age & Name - Ascending"
    case ageNameDesc = "Age & Name - Descending"
}
