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
    static let sortCell = "sortCell"
    static let sortCompanies = "sortCompanies"
}

struct AppStrings {
    static let searchForMembers = "Search for members"
    static let searchForCompanies = "Search for companies"
    static let members = "Members"
    static let company = "Company"
    static let follow = "FOLLOW"
    static let unfollow = "UNFOLLOW"
    static let ascending = "Ascending"
    static let descending = "Descending"
    static let sortBy = "Sort By"
    static let name = "Name"
    static let age = "Age"
}

enum SortOrder: CaseIterable {
    case ascending
    case descending
}

enum SortType: CaseIterable {
    case name
    case age
}

enum Feature: Int {
    case company
    case member
}
